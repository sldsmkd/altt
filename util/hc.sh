STATUSCODE=$(curl --silent --output /dev/stderr --write-out "%{http_code}" URL)
if test $STATUSCODE -ne 200; then
  echo $STATUSCODE that's an error!
fi
