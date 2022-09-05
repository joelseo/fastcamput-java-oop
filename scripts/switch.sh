#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)  # 현재 switch.sh가 속해 있는 경로를 찾는다
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh  # java로 보면 import 기능

function switch_proxy() {
  IDLE_PORT=$(find_idle_port)

  echo "> 전환할 Port : $IDLE_PORT"
  echo "> Port 전환"

  # 하나의 문장을 만들어 파이프라인으로 넘겨주기 위해 echo를 사용한다.
  # 쌍따옴표(") 사용하지 않으면 $service_url을 그대로 인식하지 못하고 변수를 찾게 된다.
  # tee 명령어 : 표준입력에서 읽은 내용을 표준출력과 파일에 쓰는 명령어 ( >> 와 유사하게 append 하려면 tee -a )
#  echo "set \$service_url http://127.0.0.1:${IDLE_PORT};" | sudo tee /etc/nginx/conf.d/service-url.inc
#  echo "> 엔진엑스 Reload"
#  sudo service nginx reload
   ssh ec2-user@10.1.1.37 /home/ec2-user/app/step3/scripts/switch.sh 8080
  # reload는 restar와 달리 끊김 없이 다시 불러온다.
}