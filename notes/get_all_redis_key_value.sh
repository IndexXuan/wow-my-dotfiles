REDIS_KEY_PATTERN="${REDIS_KEY_PATTERN:-*}"                                                                                                                 22-09-13 - 20:30:51
for key in $(redis-cli --scan --pattern "$REDIS_KEY_PATTERN")
do
    type=$(redis-cli type $key)
    if [ $type = "list" ]
    then
        printf "$key => \n$(redis-cli lrange $key 0 -1 | sed 's/^/  /')\n"
    elif [ $type = "hash" ]
    then
        printf "$key => \n$(redis-cli hgetall $key | sed 's/^/  /')\n"
    elif [ $type = "smembers" ]
    then
        printf "$key => $(redis-cli smembers $key)\n"
    elif [ $type = "zset" ]
    then
        printf "$key => $(redis-cli zrange $key 0 -1)\n"
    elif [ $type = "set" ]
    then
        printf "$key => $(redis-cli smembers $key)\n"
    else
        printf "$key => $(redis-cli get $key)\n"

    fi
done
