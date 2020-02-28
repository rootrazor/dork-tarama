#!/bin/bash


anahtar(){
	anatargetir=$(curl -s --compressed "https://cse.google.com/cse.js?cx=partner-pub-2698861478625135:3033704849" -L -D -)
	anahtar=$(echo $anatargetir | grep -Po "(?<=\"cse_token\": \")[^\"]*")
}
dorkbulak(){
	anahtar
	anahtar="partner-pub-2698861478625135:3033704849"
    dorkbulak=$(curl -s --compressed 'https://cse.google.com/cse/element/v1?num=10&hl=en&cx='''"${anahtar}"'''&safe=off&cse_tok='''"${anahtar}"'''&start='''"${2}"'''&q='''"${1}"'''&callback=x' -L -D - | grep -Po '(?<="unescapedUrl": ")[^"]*')
}
dorkgetir(){
	anahtar
	anahtar="partner-pub-2698861478625135:3033704849"
    dorkbulak=$(curl -s --compressed 'https://cse.google.com/cse/element/v1?num=10&hl=en&cx='''"${anahtar}"'''&safe=off&cse_tok='''"${anahtar}"'''&start='''"${2}"'''&q='''"${1}"'''&callback=x' -L -D - | grep -Po '(?<="unescapedUrl": ")[^"]*')
}
cat << "EOF"
     .--.
    |o_o |	
    |:_/ |   ========= Dork Arama Sistemi =========
   //   \ \  ====== Code by RootRazor ======
  (|     | ) ====== Thanks to Turkharekat =======
 /\'\_   _/`\
 \___)=(___/
EOF
echo ""
echo "Method: "
echo "1. Tek Dork Arama"
echo "2. Çoklu Dork Arama"
read -p "Seçiniz: " secin;

if [[ -z $secin ]]; then
	printf "\nSecilme Yapilamadi Kapatiliyor\n"
	exit 1
fi

if [[ $secin -eq 1 ]]; then
	read -p "Sadece Link: (y/n)? " filitre;
	read -p "Dork: " dorkmu;
	dorkna=''"$dorkmu"''
	eDork=$(echo $dorkmu | sed -f urldosyasi)
	numara=1;
	for sayfalar in {0..1000..10}; do
		printf "\n====== Sayfadan yakalama $numara ======\n"
		dorkbulak $eDork $sayfalar
		if [[ $dorkbulak == '' ]]; then
	    	printf "Link Bulunamadi\n"
	    	break;
	    else
	    	if [[ $filitre == 'y' || $filitre == 'Y' ]]; then
	    		Url=$(echo $dorkbulak | grep -Po 'http.?://([[:alnum:]_.-]+?\.){1,5}[[:alpha:].]{2,10}/')
			    echo ''"$Url"''
			    echo "$Url" >> sonuclar.tmp
	    	else
			    echo ''"$dorkbulak"''
			    echo "$dorkbulak" >> sonuclar.tmp
			fi
	    fi
	    ((numara++))
	done
elif [[ $secin -eq 2 ]]; then
	read -p "Sadece Link: (y/n)? " filitre;
	read -p "Dork Dosyasi: " dorkdosyasi;
	if [[ ! -f $dorkdosyasi ]]; then
		echo "[404] $dork_fileor bulunamadı. Dork dosya adınızı kontrol edin."
		exit 1;		
	fi
	IFS=$'\r\n' GLOBIGNORE='*' command eval 'dorkna=($(cat $dorkdosyasi))'
	for (( i = 0; i <"${#dorkna[@]}"; i++ )); do
		dorkumuz=$(echo ${dorkna[$i]} | sed -f urldosyasi)
		printf "\n[=] Dork Araniyor: ${dorkna[$i]}\n"
		numara=1;
		for sayfalar in {0..1000..10}; do
			printf "\n====== Sayfadan yakalama $numara ======\n"
			dorkgetir $dorkumuz $sayfalar
			if [[ $dorkbulak == '' ]]; then
		    	printf "Link Bulunamadi\n"
		    	break;
		    else
	    	if [[ $filitre == 'y' || $filitre == 'Y' ]]; then
	    		Url=$(echo $dorkbulak | grep -Po 'http.?://([[:alnum:]_.-]+?\.){1,5}[[:alpha:].]{2,10}/')
			    echo ''"$Url"''
			    echo "$Url" >> sonuclar.tmp
	    	else
			    echo ''"$dorkbulak"''
			    echo "$dorkbulak" >> sonuclar.tmp
			fi
		    fi
		    ((numara++))
		done
	done
else
	printf "\nKötü Girdin. Cikis Yapiliyor\n"
fi
printf "\n\n[!] Filtreleme Sonucu... \n"
zaman=$(date | sed 's/ /-/g')
cat sonuc.tmp | sort -u | uniq >> sonuclar-${zaman}.txt
printf "[+] Toplam : $(cat sonuclar-${zaman}.txt | wc -l) Site\n"
