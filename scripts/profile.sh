#!/usr/bin/env bash

# 쉬고 있는 profile 찾기: real1이 사용중 이면 real2가 쉬고 있고, 반대면 real1이 쉬고 있음
function find_idle_profile()
{
  # 현재 엔진엑스가 바라보는 스프링부트가 정상인지 HttpStatus를 받아 체크하고 , 오류 일 경우 모두 예외로 보고 real2를 현재 profile로 사용한다.
  RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/profile)

  if [ ${RESPONSE_CODE} -ge 400 ] # 400 보다 크면(즉, 40x/50x 에러 모두 포함)
  then
      CURRENT_PROFILE=real2
  else
      CURRENT_PROFILE=$(curl -s http://localhost/profile)
  fi

  if[ ${CURRENT_PROFILE} == real1 ]
  then
      IDLE_PROFILE=real2
  else
      IDLE_PROFILE=real1
  fi

  echo "${IDLE_PROFILE}" # bash 스크립트는 값을 반환하는 기능이 없어 echo로 결과를 출려한다.
}

# 쉬고 있는 profile의 port 찾기
function find_idle_port()
{
  IDLE_PROFILE=$(find_idle_profile)

  if [ ${IDLE_PROFILE} == real1 ]
  then
      echo "8081"
  else
      echo "8082"
  fi
}