#!/bin/bash



set -x



TIMESTAMP=`date "+%Y%m%d%H%M"`

BASE="fio-${TIMESTAMP}"

[ -z $1 ] && BASE="fio-${TIMESTAMP}" || BASE="fio-${1}"

JOBFILE="${BASE}.job"

CSVFILE="${BASE}.csv"



cat > ${JOBFILE} <<__EOF__

[global]

ioengine=libaio

buffered=0

bs=4k

iodepth=32

runtime=20

time_based

size=10G

ioengine=libaio

direct=1

invalidate=1

verify=0

verify_fatal=0

randrepeat=0

group_reporting

filename=/dev/sdc1

numjobs=5

fsync_on_close=1

norandommap

[readwrite]

rw=readwrite



[randread]

stonewall

rw=randread



[randwrite]

stonewall

rw=randwrite

__EOF__



trap "rm -f ${JOBFILE}" EXIT



HEADER="terse_version;fio_version;jobname;groupid;error;rd_total_io;rd_bw;rd_iops;rd_runtime;rd_slat_min;rd_slat_max;rd_slat_mean;rd_slat_stddev;rd_clat_min;rd_clat_max;rd_clat_mean;rd_clat_stddev;rd_clat_pct_01;rd_clat_pct_02;rd_clat_pct_03;rd_clat_pct_04;rd_clat_pct_05;rd_clat_pct_06;rd_clat_pct_07;rd_clat_pct_08;rd_clat_pct_09;rd_clat_pct_10;rd_clat_pct_11;rd_clat_pct_12;rd_clat_pct_13;rd_clat_pct_14;rd_clat_pct_15;rd_clat_pct_16;rd_clat_pct_17;rd_clat_pct_18;rd_clat_pct_19;rd_clat_pct_20;rd_lat_min;rd_lat_max;rd_lat_mean;rd_lat_stddev;rd_bw_min;rd_bw_max;rd_bw_agg;rd_bw_mean;rd_bw_stddev;wr_total_io;wr_bw;wr_iops;wr_runtime;wr_slat_min;wr_slat_max;wr_slat_mean;wr_slat_stddev;wr_clat_min;wr_clat_max;wr_clat_mean;wr_clat_stddev;wr_clat_pct_01;wr_clat_pct_02;wr_clat_pct_03;wr_clat_pct_04;wr_clat_pct_05;wr_clat_pct_06;wr_clat_pct_07;wr_clat_pct_08;wr_clat_pct_09;wr_clat_pct_10;wr_clat_pct_11;wr_clat_pct_12;wr_clat_pct_13;wr_clat_pct_14;wr_clat_pct_15;wr_clat_pct_16;wr_clat_pct_17;wr_clat_pct_18;wr_clat_pct_19;wr_clat_pct_20;wr_lat_min;wr_lat_max;wr_lat_mean;wr_lat_stddev;wr_bw_min;wr_bw_max;wr_bw_agg;wr_bw_mean;wr_bw_stddev;cpu_usr;cpu_sys;cpu_ctx;cpu_maj_pf;cpu_min_pf;iodep_1;iodep_2;iodep_4;iodep_8;iodep_16;iodep_32;iodep_64;iolat_us_2;iolat_us_4;iolat_us_10;iolat_us_20;iolat_us_50;iolat_us_100;iolat_us_250;iolat_us_500;iolat_us_750;iolat_us_1000p;iolat_ms_2;iolat_ms_4;iolat_ms_10;iolat_ms_20;iolat_ms_50;iolat_ms_100;iolat_ms_250;iolat_ms_500;iolat_ms_750;iolat_ms_1000;iolat_ms_2000;iolat_ms_2000p;disk_name;disk_rd_ios;disk_wr_ios;disk_rd_merges;disk_wr_merges;disk_rd_ticks;disk_wr_ticks;disk_io_queue;disk_util"



[ -e ${CSVFILE} ] || echo ${HEADER} > ${CSVFILE}



for run in `seq 5` ; do

        sync

        fio --minimal ${JOBFILE} >> ${CSVFILE}

done

