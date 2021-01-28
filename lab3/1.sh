#!/bin/bash
date_time=$(date +"%d-%m-%Y_%H-%M-%S")
mkdir $HOME/test 2>/dev/null &&
  {
    echo "catalog test was created successfully" >>~/report
    touch $HOME/test/$date_time
  }
date=$(date +"%d-%m-%Y")
ping "www.net_nikogo.ru" -c 1 2>/dev/null || echo $date' "www.net_nikogo.ru" is not available' >>~/report
