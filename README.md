

INSTALL SCRIPT 
<pre><code>wget --no-check-certificate https://tinyurl.com/setup20 -O san.sh && chmod +x san.sh && ./san.sh</code></pre>

MANUAL UPDATE
<pre><code>wget https://raw.githubusercontent.com/Paper890/san/main/update.sh && chmod +x update.sh && ./update.sh</code></pre>

JIKA LINL INSTALL FORBIDDEN GUANAKAN INI
<pre><code>wget -q https://raw.githubusercontent.com/Paper890/san/main/setup1.sh && chmod +x setup1.sh && screen -S install ./setup1.sh
</code></pre>

INSTALL AUTO BACKUP 
<pre><code>wget -q https://raw.githubusercontent.com/Paper890/san/main/backup/auto.sh && chmod +x auto.sh && ./auto.sh </code></pre>
TESTED ON OS 
- UBUNTU 20.04.05
- DEBIAN 10

fix Haproxy Off:
user haproxy
group haproxy
