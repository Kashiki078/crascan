#!/bin/bash
# Crascan v1.3
# Release on 12/09/2018
# © Copyright ~ 4WSec

clear

# color
f=3 b=4s
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done

time=`date +"%T"`

useragents="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:61.0) Gecko/20100101 Firefox/61.0"

# banner
banner(){
printf "\t${f6}        _______\n"
printf "\t${f6}      _/       \_\n"
printf "\t${f6}     / |       | \ \n"
printf "\t${f6}    /  |__   __|  \ \n"
printf "\t${f6}   |__/((o| |o))\__|\n"
printf "\t${f6}   |      | |      |\n"
printf "\t${f6}   |\     |_|     /|\n"
printf "\t${f6}   | \           / |\n"
printf "\t${f6}    \| /  ___  \ |/\n"
printf "\t${f6}     \ | / _ \ | /\n"
printf "\t${f6}      \_________/\n"
printf "\t${f6}       _|_____|_\n"
printf "\t${f6}  ____|_________|____\n"
printf "\t${f6} /___________________\  -- ${f2}Crascan v1.3\n"

echo ""
echo "${f3}Author     : ${f7}Arya Narotama (4WSec)"
echo "${f3}Team       : ${f7}Anon Cyber Team"
echo "${f3}Disclaimer : ${f7}I am not responsible for damage caused by Crascan. Attacking targets without mutual consent is illegal!"
}

# menu
banner
echo ""
echo "${f2}[ ${f1}Crascan Menu ${f2}]"
echo ""
echo "   ${f2}[${f1}1${f2}] ${f6}LFI ${f5}Scanner          ${f2}[${f1}5${f2}] ${f6}Files ${f5}Scanner"
echo "   ${f2}[${f1}2${f2}] ${f6}RFI ${f5}Scanner          ${f2}[${f1}6${f2}] ${f6}Joomla Components ${f5}Scanner"
echo "   ${f2}[${f1}3${f2}] ${f6}RCE ${f5}Scanner          ${f2}[${f1}7${f2}] ${f6}Admin Page ${f5}Finder"
echo "   ${f2}[${f1}4${f2}] ${f6}Directory ${f5}Scanner    ${f2}[${f1}8${f2}] ${f6}Shell ${f5}Scanner"
echo ""
echo -e ${f6}"┌─[${f1}Crascan${f6}]──[${f1}Skid${f6}]"
read -p "└─────► " cras;
echo "${f1}Ex: ${f7}http://0x666.com"
read -p "${f2}[${f1}*${f2}]${f1} Input URL${f2}> "  urlz;
read -p "${f2}[${f1}*${f2}]${f1} Input Threads${f2}> " thread;


######### Save Result ###########
save1="result/result-lfi.txt"
save2="result/result-rfi.txt"
save3="result/result-rce.txt"
save4="result/result-dir.txt"
save5="result/result-files.txt"
save6="result/result-joomla-components.txt"
save7="result/result-admin.txt"
save8="result/result-shell.txt"
#################################

######
con=1
######

##########
miring=/
##########


######################### Func Curl ############################################
# func lfi
lfi(){
	scan=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}${zlfi})
	if [[ $scan == 200 ]] || [[ $scan == 301 ]] || [[ $scan =~ "/etc/passwd" ]]; then
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zlfi ~> ${f6}[${f7}OK${f6}]${f2}"
		echo "$urlz$miring$zlfi" >> $save1
	elif [[ $scan =~ "/bin/bash" ]]; then
			echo "${f2}[${f3}$time${f2}] $urlz$miring$zlfi ~> ${f6}[${f3}OK${f6}]${f2}"
			echo "$urlz$miring$zlfi" >> $save1
		else
			echo "${f2}[${f3}$time${f2}] $urlz$miring$zlfi ~> ${f6}[${f1}FAIL${f6}]${f2}"
	fi
}

# func rfi
rfi(){
	scan2=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}${zrfi})
	if [[ $scan2 == 200 ]] || [[ $scan2 == 301 ]] || [[ $scan2 =~ "/etc/passwd" ]]; then
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zrfi ~> ${f6}[${f7}OK${f6}]${f2}"
		echo "$urlz$miring$zrfi" >> $save2
	else
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zrfi ~> ${f6}[${f1}FAIL${f6}]${f2}"
	fi
	
}

# func rce
rce(){
	scan3=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}${zrce})
	if [[ $scan3 == 200 ]] || [[ $scan3 == 301 ]] || [[ $scan3 =~ "/etc/passwd" ]]; then
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zrce ~> ${f6}[${f7}OK${f6}]${f2}"
		echo "$urlz$miring$zrce" >> $save3
	elif [[ $scan3 =~ "/etc/passwd" ]]; then
			echo "${f2}[${f3}$time${f2}] $urlz$miring$zrce ~> ${f6}[${f7}OK${f6}]${f2}"
			echo "$urlz$miring$zrce" >> $save3
		else
			echo "{f2}[${f3}$time${f2}] $urlz$miring$zrce ~> ${f6}[${f1}FAIL${f6}]${f2}"
	fi
	
}

# func dir
dir(){
	scan4=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}${zdir})
	if [[ $scan4 == 200 ]] || [[ $scan4 == 301 ]]; then
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zdir ~> ${f6}[${f7}OK${f6}]${f2}"
		echo "$urlz$miring$zdir" >> $save4
	else
		echo "{f2}[${f3}$time${f2}] $urlz$miring$zdir ~> ${f6}[${f1}FAIL${f6}]${f2}"
	fi
	
}

# func files
files(){
	scan5=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}${zfiles})
	if [[ $scan5 == 200 ]] || [[ $scan5 == 301 ]]; then
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zfiles ~> ${f6}[${f7}OK${f6}]${f2}"
		echo "$urlz$miring$zfiles" >> $save5
	else
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zfiles ~> ${f6}[${f1}FAIL${f6}]${f2}"
	fi
	
}

# func joomla
joomcom(){
	scan6=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}${zjoom})
	if [[ $scan6 == 200 ]] || [[ $scan6 == 304 ]] || [[ $scan6 == 301 ]]; then
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zjoom ~> ${f6}[${f7}OK${f6}]${f2}"
		echo "$urlz$miring$zjoom" >> $save6
	else
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zjoom ~> ${f6}[${f1}FAIL${f6}]${f2}"

	fi
}

# func admin page finder
admf(){
	scan7=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}${zadmf})
	if [[ $scan7 == 200 ]] || [[ $scan7 == 301 ]] || [[ $scan7 =~ "password" ]] || [[ $scan7 =~ "login" ]]; then
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zadmf ~> ${f6}[${f7}OK${f6}]${f2}"
		echo "$urlz$miring$zadmf" >> $save7
	else
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zadmf ~> ${f6}[${f1}FAIL${f6}]${f2}"
	fi
}

# func shell scanner
shellscn(){
	scan8=$(curl -s -A '${useragents}' -o /dev/null -w '%{http_code}' ${urlz}${miring}$zshellscn)
	word="IndoXploit|wso|Shell|symlink|b374k|c99|deface|Upload|Deface|Hacked|NoName" # Edit Here
	ngecek=$(echo $scan8 | tr [:upper:] [:lower:])
	if [[ $ngecek == 200 ]] || [[ $ngecek =~ ($word) ]]; then
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zshellscn ~> ${f6}[${f7}OK${f6}]${f2}"
		echo "$urlz$miring$zshellscn" >> $save7
	else
		echo "${f2}[${f3}$time${f2}] $urlz$miring$zshellscn ~> ${f6}[${f1}FAIL${f6}]${f2}"
	fi
}
############################################################################




###################### LIST ######################
ceklistlfi(){
listlfi=$(wc -l lib/LFI | cut -f1 -d '')
echo "Total LFI List ~> $listlfi"
}

ceklistrfi(){
listrfi=$(wc -l lib/RFI | cut -f1 -d '')
echo "Total RFI List ~> $listrce"
}

ceklistrce(){
listrce=$(wc -l lib/RCE | cut -f1 -d '')
echo "Total RCE List ~> $listrce"
}

ceklistdir(){
listdir=$(wc -l lib/Dir | cut -f1 -d '')
echo "Total Directory List ~> $listdir"
}

ceklistfiles(){
listfiles=$(wc -l lib/Files | cut -f1 -d '')
echo "Total Files List ~> $listfiles"
}

ceklistjoom(){
listjoom=$(wc -l lib/Components | cut -f1 -d '')
echo "Total Components ~> $listjoom"
}

ceklistadmf(){
listadmf=$(wc -l lib/AdminList | cut -f1 -d '')
echo "Total Admin Page List ~> $listadmf"
}

ceklistshellscn(){
listshellscn=$(wc -l lib/wordlist-shell | cut -f1 -d '')
echo "Total Wordlist ~> $listshellscn"
}
#################################################


############ Ekse (LFI) ####################
luplfi(){
for zlfi in $(cat lib/LFI)
do
	fast=$(expr $con % $thread)
	if [[ $fast == 0 && $con > 0 ]]; then
		sleep 3
	fi
	lfi & 
	con=$[$con+1]
done
wait
echo "${f6}[ ${f7}RESULT ON ${f1}result/result-lfi.txt ${f6}]"
cat $save1
}
############################################


############ Ekse (RFI) ####################
luprfi(){
for zrfi in $(cat lib/RFI)
do
	fast=$(expr $con % $thread)
	if [[ $fast == 0 && $con > 0 ]]; then
		sleep 3
	fi
	rfi & 
	con=$[$con+1]
done
wait
echo "${f6}[ ${f7}RESULT ON ${f1}result/result-rfi.txt ${f6}]"
cat $save2
}
############################################



############ Ekse (RCE) ####################
luprce(){
for zrce in $(cat lib/RCE)
do
	fast=$(expr $con % $thread)
	if [[ $fast == 0 && $con > 0 ]]; then
		sleep 3
	fi
	rce & 
	con=$[$con+1]
done
wait
echo "${f6}[ ${f7}RESULT ON ${f1}result/result-rce.txt ${f6}]"
cat $save3
}
############################################


############ Ekse (DIR) ####################
lupdir(){
for zdir in $(cat lib/Dir)
do
	fast=$(expr $con % $thread)
	if [[ $fast == 0 && $con > 0 ]]; then
		sleep 3
	fi
	dir & 
	con=$[$con+1]
done
wait
echo "${f6}[ ${f7}RESULT ON ${f1}result/result-dir.txt ${f6}]"
cat $save4
}
############################################


############ Ekse (FILES) ####################
lupfiles(){
for zfiles in $(cat lib/Files)
do
	fast=$(expr $con % $thread)
	if [[ $fast == 0 && $con > 0 ]]; then
		sleep 3
	fi
	files & 
	con=$[$con+1] 
done
wait
echo "${f6}[ ${f7}RESULT ON ${f1}result/result-files.txt ${f6}]"
cat $save5
}
#############################################


######### Ekse (Joomla Components) ##########
lupjoom(){
for zjoom in $(cat lib/Components)
do
	fast=$(expr $con % $thread)
	if [[ $fast == 0 && $con > 0 ]]; then
		sleep 3
	fi
	joomcom & 
	con=$[$con+1]
done
wait
echo "${f6}[ ${f7}RESULT ON ${f1}result/result-joomla-components.txt ${f6}]"
cat $save6
}
############################################

########## Ekse (Admin Page Finder) ###########
lupadmf(){
for zadmf in $(cat lib/AdminList)
do
	fast=$(expr $con % $thread)
	if [[ $fast == 0 && $con > 0 ]]; then
		sleep 3
	fi
	admf & 
	con=$[$con+1]	
done
wait
echo "${f6}[ ${f7}RESULT ON ${f1}result/result-joomla-components.txt ${f6}]"
cat $save7
}
############################################

######### Shell Scanner ###################
lupshellscn(){
for zshellscn in $(cat lib/wordlist-shell)
do
	fast=$(expr $con % $thread)
	if [[ $fast == 0 && $con > 0 ]]; then
		sleep 3
	fi
	shellscn &
	con=$[$con+1]
done
wait
echo "${f6}[ ${f7}RESULT ON ${f1}result/result-shell.txt ${f6}]"
}



############## Condition #################
if [[ $cras == 1 ]]; then
	echo "${f2}[${f1}!${f2}] Scanning on ${f7}LFI ${f2}..."
	sleep 2
	ceklistlfi
	sleep 1
	luplfi
elif [[ $cras == 2 ]]; then
	echo "${f2}[${f1}!${f2}] Scanning on ${f7}RFI ${f2}..."
	sleep 2
	ceklistrfi
	sleep 1
	luprfi
elif [[ $cras == 3 ]]; then
	echo "${f2}[${f1}!${f2}] Scanning on ${f7}RCE ${f2}..."
	sleep 2
	ceklistrce
	sleep 1
	luprce
elif [[ $cras == 4 ]]; then
	echo "${f2}[${f1}!${f2}] Scanning on ${f7}Directory ${f2}..."
	sleep 2
	ceklistdir
	sleep 1
	lupdir
elif [[ $cras == 5 ]]; then
	echo "${f2}[${f1}!${f2}] Scanning on ${f7}Files ${f2}..."
	sleep 2
	ceklistfiles
	sleep 1
	lupfiles
elif [[ $cras == 6 ]]; then
	echo "${f2}[${f1}!${f2}] Scanning on ${f7}Joomla Components ${f2}..."
	sleep 2
	ceklistjoom
	sleep 1
	lupjoom
elif [[ $cras == 7 ]]; then
	echo "${f2}[${f1}!${f2}] ${f7}Admin Page Finder ${f2}..."
	sleep 2
	ceklistadmf
	sleep 1
	lupadmf
elif [[ $cras == 8 ]]; then
	echo "${f2}[${f1}!${f2}] ${f7}Shell Scanner ${f2}..."
	sleep 2
	ceklistshellscn
	sleep 1
	lupshellscn
else
	echo "${f2}[${f1}X${f2}]${f4} Wrong Command!"
fi
##########################################
