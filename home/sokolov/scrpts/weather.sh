#!/bin/bash

city_code="$1"
cache="$HOME/.cache/gismeteo/"

if [[ -z "$@" ]] || [[ "$1" == "-h" ]]; then
	echo -e "Параметры запуска:
		weather.sh [код_города] [глубина_прогноза] [запрашиваемая информация] [координаты_изображения] 
		код_города - узнать на сайте gismeteo.ru
		глубина_прогноза - число от 1 до 4. Gismeteo выдает всего 4 дня в rss за раз.
		запрашиваемая_информация:
			p - давление
			w - ветер
			t - температура
			d - дата
			image - изображение погоды
			"
	
	exit
fi

conky_ver=$(conky -v|head -n 1|awk {'print $2'})
src=$(curl -s "http://informer.gismeteo.ru/rss/${city_code}.xml"|egrep "title|description|enclosure"|tail -n +4|sed -r "s/<\/?((title)|(description))>//g"  )

case "$2" in
	2)	day=4
		;;
	3)	day=7
		;;
	4)	day=10
		;;
	1)	day=1
		;;
	*)	echo "Второй аргумент должен быть числом от 1 до 4"
		exit 1
		;;
esac

src_cur=$(echo -e "$src"|tail -n +$day|head -n 3)
	
if [[ "$(echo $conky_ver|awk -F\. {'print $1'})" -ge "1" ]] && [[ "$(echo $conky_ver|awk -F\. {'print $2'})" -ge "6" ]] && [[ "$3" == "image" ]] ; then
	if [[ ! -d $cache ]] ; then mkdir $cache ; fi
	src_image=$(echo "$src_cur"|grep enclosure|awk -F\" {'print $2'})
	image=$(basename $src_image)
	if [[ ! -f "$cache/$image" ]] ; then
		wget -nc --quiet $src_image -O $cache/$image
	fi
	echo "\${image $cache/$image -p $4}"
	exit 0
fi		

for i in $(echo "$3"|sed s/./" &"/g)
do
	info_cur=$(echo "$src_cur"|grep "температура ")

	case "$i" in
		d)
			echo -ne "$src_cur"|grep \:|grep -v enclosure|awk {'print $2" "$3" "$4'}|sed s/Aug/Август/g|sed s/,//g
			;;

		t)
			echo "$info_cur"|awk -F "температура " {'print $2'}|awk {'print $1'}
			;;
		p)
			echo "$info_cur"|awk -F "давление" {'print $2'}|awk {'print $1'}
			;;
		w)
			echo "$info_cur"|awk -F "ветер" {'print $2'}
			;;
		*)
			echo "Ошибка: неизвестный параметр"
			;;
	esac
done
