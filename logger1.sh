#/bin/bash

while sleep 1; do
  # get process id for ipfs daemon
  output=`ps aux | grep "ipfs daemon" | grep -v grep`
  set -- $output
  pid=$2
  # get timestamp
  timestamp=$(date +%s)
  # get process memory usage in kilobytes
  res_mem=`ps -p $pid -o rss | tail -1`
  # get ipfs repo size in bytes
  output=`ipfs repo stat | grep RepoSize`
  set -- $output
  repo_size=$2
  # get ipfs peer count
  peer_count=`ipfs swarm peers | wc -l`
  # write to log file
  echo "$timestamp $res_mem $repo_size $peer_count"
  echo "$timestamp $res_mem $repo_size $peer_count" >> ipfs_log
done
