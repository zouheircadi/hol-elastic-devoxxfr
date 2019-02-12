VERSION=6.6.0
ELASTIC_BIN=elasticsearch-${VERSION}.tar.gz

KIBANA_MACOS_BIN=kibana-${VERSION}-darwin-x86_64.tar.gz
KIBANA_MACOS_FOLDER=kibana-${VERSION}-darwin-x86_64

KIBANA_LINUX_BIN=kibana-${VERSION}-linux-x86_64.tar.gz
KIBANA_LINUX_FOLDER=kibana-${VERSION}-linux-x86_64

LOGSTASH_BIN=logstash-${VERSION}.tar.gz


mkdir -p $HOME/elastic/downloads ; cd $HOME/elastic


# Installation Elastic
wget https://artifacts.elastic.co/downloads/elasticsearch/$ELASTIC_BIN
mkdir $HOME/elastic/search ; tar -xvf $ELASTIC_BIN -C $HOME/elastic/search
mv $HOME/elastic/search/elasticsearch-$VERSION $HOME/elastic/search/$VERSION
mv $HOME/elastic/$ELASTIC_BIN $HOME/elastic/downloads/$ELASTIC_BIN

# Installation Kibana
OS="`uname`"
case $OS in
  'Linux')
     wget https://artifacts.elastic.co/downloads/kibana/$KIBANA_LINUX_BIN
     mkdir $HOME/elastic/kibana ; tar -xvf $KIBANA_LINUX_BIN -C $HOME/elastic/kibana
     mv $HOME/elastic/kibana/$KIBANA_MACOS_FOLDER $HOME/elastic/kibana/$VERSION
     mv $HOME/elastic/$KIBANA_LINUX_BIN $HOME/elastic/downloads/$KIBANA_LINUX_BIN     
    ;;
  'Darwin')
     wget https://artifacts.elastic.co/downloads/kibana/$KIBANA_MACOS_BIN
     mkdir $HOME/elastic/kibana ; tar -xvf $KIBANA_MACOS_BIN -C $HOME/elastic/kibana
     mv $HOME/elastic/kibana/$KIBANA_MACOS_FOLDER $HOME/elastic/kibana/$VERSION
     mv $HOME/elastic/$KIBANA_MACOS_BIN $HOME/elastic/downloads/$KIBANA_MACOS_BIN     
    ;;
  *) ;;
esac



# Installation logstash
wget https://artifacts.elastic.co/downloads/logstash/$LOGSTASH_BIN
mkdir $HOME/elastic/logstash ; tar -xvf $LOGSTASH_BIN -C $HOME/elastic/logstash
mv $HOME/elastic/logstash/logstash-$VERSION $HOME/elastic/logstash/$VERSION
mv $HOME/elastic/$LOGSTASH_BIN $HOME/elastic/downloads/$LOGSTASH_BIN

export ELK_HOME=$HOME/elastic