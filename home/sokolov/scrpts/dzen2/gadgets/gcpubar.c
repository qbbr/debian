/*  
    gcpubar - graphical cpu usage bar, to be used with dzen
  
    Copyright (C) 2007 by Robert Manea, <rob dot manea at gmail dot com>
 
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

/* critical % value */
#define CPUCRIT 75
/* bar color for critical values */
#define CRITCOL "red"

static void pbar (double, int, int, int, int);

struct cpu_info {
	unsigned long long user;
	unsigned long long sys;
	unsigned long long idle;
	unsigned long long iowait;
} ncpu, ocpu;

char *bg, *fg;

static void
pbar(double perc, int maxc, int height, int print_nl, int mode) {
	int i, rp;
	double l;

	l = perc * ((mode ? (double)(maxc-2) : (double) maxc) / 100);
	if((int)(l + 0.5) >= (int)l)
		l = l + 0.5;

	if((int)(perc + 0.5) >= (int)perc)
		rp = (int)(perc + 0.5);
	else
		rp = (int)perc;

	if(mode)
		printf("CPU: %3d%% ^ib(1)^fg(%s)^ro(%dx%d)^p(%d)^fg(%s)^r(%dx%d)^fg()%s", 
				rp, bg, maxc, height, -1*(maxc-1),
				(rp>=CPUCRIT) ? CRITCOL : fg, (int)l, height-2, print_nl ? "\n" : "");
	else
		printf("CPU: %3d%% ^fg(%s)^r(%dx%d)^fg(%s)^r(%dx%d)^fg()%s", 
				rp, (rp>=CPUCRIT) ? CRITCOL : fg, (int)l, height,
				bg, maxc-(int)l, height, print_nl ? "\n" : "");

	fflush(stdout);
}

int 
main(int argc, char *argv[])
{
	int i, t;
	double total;
	struct cpu_info mcpu;
	FILE *statfp;
	char buf[256], *ep;

	/* defaults */
	int mode      = 0; 
	double ival   = 1.0;
	int counts    = 0;
	int barwidth  = 100;
	int barheight = 10;
	int print_nl  = 1;

	for(i=1; i < argc; i++) {
		if(!strncmp(argv[i], "-i", 3)) {
			if(i+1 < argc) {
				ival = strtod(argv[i+1], &ep);
				if(*ep) {
					fprintf(stderr, "%s: '-i'  Invalid interval value\n", argv[0]);
					return EXIT_FAILURE;
				}
				else
					i++;
			}
		}
		else if(!strncmp(argv[i], "-o", 3)) {
				mode = 1;
		}
		else if(!strncmp(argv[i], "-c", 3)) {
			if(++i < argc)
				counts = atoi(argv[i]);
		}
		else if(!strncmp(argv[i], "-w", 3)) {
			if(++i < argc)
				barwidth = atoi(argv[i]);
		}
		else if(!strncmp(argv[i], "-h", 3)) {
			if(++i < argc)
				barheight = atoi(argv[i]);
		}
		else if(!strncmp(argv[i], "-fg", 4)) {
			if(++i < argc)
				fg = argv[i];
			else {
				fg = malloc(6);
				strcpy(fg, "white");
			}
		}
		else if(!strncmp(argv[i], "-bg", 4)) {
			if(++i < argc)
				bg = argv[i];
			else {
				bg = malloc(9);
				strcpy(bg, "darkgrey");
			}
		}
		else if(!strncmp(argv[i], "-nonl", 6)) {
			print_nl = 0;
		}
		else {
			printf("usage: %s [-i <interval>] [-c <count>] [-fg <color>] [-bg <color>] [-w <pixel>] [-h <pixel>] [-nonl]\n", argv[0]);
			return EXIT_FAILURE;
		}
	}

	if(!fg) {
		fg = malloc(6);
		strcpy(fg, "white");
	}
	if(!bg) {
		bg = malloc(9);
		strcpy(bg, "darkgrey");
	}

	if(!(statfp = fopen("/proc/stat", "r"))) {
		printf("%s: error opening '/proc/stat'\n", argv[0]);
		return EXIT_FAILURE;
	}

	t = counts > 0 ? counts : 1;
	while(t) {
		rewind(statfp); 
		while(fgets(buf, sizeof buf, statfp)) {
			if(!strncmp(buf, "cpu ", 4)) {
				unsigned long long unice;
				double myload;
				/* linux >= 2.6 */
				if((sscanf(buf, "cpu %llu %llu %llu %llu %llu", 
						&ncpu.user, &unice, &ncpu.sys, &ncpu.idle, &ncpu.iowait)) < 5) {
					printf("%s: wrong field count in /proc/stat\n", argv[0]);
					return EXIT_FAILURE;
				}
				ncpu.user += unice;

				mcpu.user   = ncpu.user - ocpu.user;
				mcpu.sys = ncpu.sys - ocpu.sys;
				mcpu.idle   = ncpu.idle - ocpu.idle;
				mcpu.iowait = ncpu.iowait - ocpu.iowait;

				total  = (mcpu.user + mcpu.sys + mcpu.idle + mcpu.iowait) / 100.0;
				myload = (mcpu.user + mcpu.sys + mcpu.iowait) / total;

				pbar(myload, barwidth, barheight, print_nl, mode);
				ocpu = ncpu;
			}
		}
		if((counts > 0) && (t-1 > 0)) {
			--t;
			usleep((unsigned long)(ival * 1000000.0));
		}
		else if((counts == 0) && (t == 1))
			usleep((unsigned long)(ival * 1000000.0));
		else 
			break;
	}
  
  return EXIT_SUCCESS;
}

