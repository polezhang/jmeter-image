sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories &&
  apk update &&
  apk upgrade &&
  apk add --update openjdk${JAVA_VERSION} wget tar bash &&
  wget https://mirrors.tuna.tsinghua.edu.cn/apache/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz &&
  wget https://jmeter-plugins.org/files/packages/jpgc-casutg-2.9.zip &&
  wget https://jmeter-plugins.org/files/packages/jpgc-tst-2.5.zip &&
  wget https://github.com/metersphere/jmeter-backend-listener-kafka/releases/download/v${KAFKA_BACKEND_LISTENER_VERSION}/jmeter.backendlistener.kafka-${KAFKA_BACKEND_LISTENER_VERSION}.jar &&
  wget https://github.com/metersphere/jmeter-plugins-for-apache-dubbo/releases/download/${DUBBO_JMETER_PLUGIN_VERSION}/jmeter-plugins-dubbo-${DUBBO_JMETER_PLUGIN_VERSION}-jar-with-dependencies.jar &&
  wget https://repo1.maven.org/maven2/org/python/jython-standalone/2.7.2/jython-standalone-2.7.2.jar &&
  wget "http://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar" -O mysql-connector-java.jar &&
  wget "http://search.maven.org/remotecontent?filepath=com/oracle/database/jdbc/ojdbc8/19.7.0.0/ojdbc8-19.7.0.0.jar" -O ojdbc8.jar &&
  wget "http://search.maven.org/remotecontent?filepath=org/postgresql/postgresql/42.2.14/postgresql-42.2.14.jar" -O postgresql.jar &&
  wget "http://search.maven.org/remotecontent?filepath=com/microsoft/sqlserver/mssql-jdbc/7.4.1.jre8/mssql-jdbc-7.4.1.jre8.jar" -O mssql-jdbc.jar &&
  mkdir -p /opt/jmeter &&
  tar -zxf apache-jmeter-${JMETER_VERSION}.tgz -C /opt/jmeter/ --strip-components=1 &&
  unzip -o jpgc-casutg-2.9.zip -d /tmp/ && mv /tmp/lib/ext/jmeter-plugins-casutg-2.9.jar /opt/jmeter/lib/ext &&
  unzip -o jpgc-tst-2.5.zip -d /tmp/ && mv /tmp/lib/ext/jmeter-plugins-tst-2.5.jar /opt/jmeter/lib/ext &&
  mv jmeter.backendlistener.kafka-${KAFKA_BACKEND_LISTENER_VERSION}.jar /opt/jmeter/lib/ext &&
  mv jmeter-plugins-dubbo-${DUBBO_JMETER_PLUGIN_VERSION}-jar-with-dependencies.jar /opt/jmeter/lib/ext &&
  mv mysql-connector-java.jar /opt/jmeter/lib/ext &&
  mv ojdbc8.jar /opt/jmeter/lib/ext &&
  mv postgresql.jar /opt/jmeter/lib/ext &&
  mv mssql-jdbc.jar /opt/jmeter/lib/ext &&
  mv jython-standalone-2.7.2.jar /opt/jmeter/lib/ext &&
  rm -rf apache-jmeter-${JMETER_VERSION}.tgz &&
  rm -rf jpgc-casutg-2.9.zip &&
  rm -rf jpgc-tst-2.5.zip &&
  rm -rf jmeter.backendlistener.kafka-${KAFKA_BACKEND_LISTENER_VERSION}.jar &&
  rm -rf jmeter-plugins-dubbo-${DUBBO_JMETER_PLUGIN_VERSION}-jar-with-dependencies.jar &&
  rm -rf /var/cache/apk/* &&
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo "$TZ" >/etc/timezone
