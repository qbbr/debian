/*  
	dbar - ascii percentage meter

	Copyright (c) 2007 by Robert Manea  <rob dot manea at gmail dot com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/


#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<string.h>

#define MAXLEN 512

static void pbar (const char*, double, int, char, int);


static void
pbar(const char* label, double perc, int maxc, char sym, int pnl) {
	int i, rp;
	double l;

	l = perc * ((double)maxc / 100);
	if((int)(l + 0.5) >= (int)l)
		l = l + 0.5;

	if((int)(perc + 0.5) >= (int)perc)
		rp = (int)(perc + 0.5);
	else
		rp = (int)perc;

	if(label)
		printf("%s %3d%% [", label, rp);
	else
		printf("%3d%% [", rp);

	for(i=0; i < (int)l; i++)
		if(i == maxc) {
			putchar('>');
			break;
		} else
			putchar(sym);

		for(; i < maxc; i++)
			putchar(' ');

		printf("]%s", pnl ? "\n" : "");
		fflush(stdout);
}

	int
main(int argc, char *argv[])
{
	int i, nv;
	double val;
	char aval[MAXLEN], *endptr;

	/* defaults */
	int maxchars  =   25;
	double minval =    0;
	double maxval =  100.0;
	char psym     =  '=';
	int print_nl  =    1;
	const char *label = NULL;


	for(i=1; i < argc; i++) {
		if(!strncmp(argv[i], "-w", 3)) {
			if(++i < argc)
				maxchars = atoi(argv[i]);
		}
		else if(!strncmp(argv[i], "-s", 3)) {
			if(++i < argc)
				psym = argv[i][0];
		}
		else if(!strncmp(argv[i], "-max", 5)) {
			if(++i < argc) {
				maxval = strtod(argv[i], &endptr);
				if(*endptr) {
					fprintf(stderr, "dbar: '%s' incorrect number format", argv[i]);
					return EXIT_FAILURE;
				}
			}
		}
		else if(!strncmp(argv[i], "-min", 5)) {
			if(++i < argc) {
				minval = strtod(argv[i], &endptr);
				if(*endptr) {
					fprintf(stderr, "dbar: '%s' incorrect number format", argv[i]);
					return EXIT_FAILURE;
				}
			}
		}
		else if(!strncmp(argv[i], "-l", 3)) {
			if(++i < argc)
				label = argv[i];
		}
		else if(!strncmp(argv[i], "-nonl", 6)) {
			print_nl = 0;
		}
		else {
			fprintf(stderr, "usage: dbar [-w <characters>] [-s <symbol>] [-min <minvalue>] [-max <maxvalue>] [-l <string>] [-nonl]\n");
			return EXIT_FAILURE;
		}
	}

	while(fgets(aval, MAXLEN, stdin)) {
		nv = sscanf(aval, "%lf %lf %lf", &val, &minval, &maxval);
		if(nv == 2) {
			maxval = minval;
			minval = 0;
		}

		pbar(label, (100*(val-minval))/(maxval-minval), maxchars, psym, print_nl);
	}

	return EXIT_SUCCESS;
}

