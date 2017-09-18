#!/system/bin/sh
# Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

#
# Copy qcril.db if needed for RIL
#
if [ -f /vendor/qcril.db -a ! -f /data/misc/radio/qcril.db ]; then
    cp /vendor/qcril.db /data/misc/radio/qcril.db
    chown -h radio.radio /data/misc/radio/qcril.db
fi
echo 1 > /data/misc/radio/db_check_done
chown radio.radio /data/misc/radio/db_check_done

#
# Make modem config folder and copy firmware config to that folder for RIL
#
if [ -f /data/misc/radio/ver_info.txt ]; then
    prev_version_info=`cat /data/misc/radio/ver_info.txt`
else
    prev_version_info=""
fi

cur_version_info=`cat /firmware/verinfo/ver_info.txt`
if [ ! -f /firmware/verinfo/ver_info.txt -o "$prev_version_info" != "$cur_version_info" ]; then
    rm -rf /data/misc/radio/modem_config
    rm /data/misc/radio/ver_info.txt
    mkdir /data/misc/radio/modem_config
    chmod 770 /data/misc/radio/modem_config
    cp -r /firmware/image/modem_pr/mcfg/configs/* /data/misc/radio/modem_config
    chown -hR radio.radio /data/misc/radio/modem_config
    cp /firmware/verinfo/ver_info.txt /data/misc/radio/ver_info.txt
    chown radio.radio /data/misc/radio/ver_info.txt
fi
cp /vendor/etc/mbn_ota.txt /data/misc/radio/modem_config
chown radio.radio /data/misc/radio/modem_config/mbn_ota.txt
echo 1 > /data/misc/radio/copy_complete
chown radio.radio /data/misc/radio/copy_complete

#
# start ril-daemon only for targets on which radio is present
#
baseband=`getprop ro.baseband`
sgltecsfb=`getprop persist.radio.sglte_csfb`
datamode=`getprop persist.data.mode`
netmgr=`getprop ro.use_data_netmgrd`

case "$baseband" in
    "apq")
    setprop ro.radio.noril yes
    stop ril-daemon
esac

case "$baseband" in
    "msm" | "csfb" | "svlte2a" | "mdm" | "mdm2" | "sglte" | "sglte2" | "dsda2" | "unknown" | "dsda3")
    start qmuxd
    start ipacm
    case "$baseband" in
        "svlte2a" | "csfb")
          start qmiproxy
        ;;
        "sglte" | "sglte2" )
          if [ "x$sgltecsfb" != "xtrue" ]; then
              start qmiproxy
          else
              setprop persist.radio.voice.modem.index 0
          fi
        ;;
        "dsda2")
          setprop persist.radio.multisim.config dsda
    esac

    multisim=`getprop persist.radio.multisim.config`

    if [ "$multisim" = "dsds" ] || [ "$multisim" = "dsda" ]; then
        start ril-daemon2
    elif [ "$multisim" = "tsts" ]; then
        start ril-daemon2
        start ril-daemon3
    fi

    case "$datamode" in
        "tethered")
            start qti
            start port-bridge
            ;;
        "concurrent")
            start qti
            if [ "$netmgr" = "true" ]; then
                start netmgrd
            fi
            ;;
        *)
            if [ "$netmgr" = "true" ]; then
                start netmgrd
            fi
            ;;
    esac
esac

#
# Allow persistent faking of bms
# User needs to set fake bms charge in persist.bms.fake_batt_capacity
#
fake_batt_capacity=`getprop persist.bms.fake_batt_capacity`
case "$fake_batt_capacity" in
    "") ;; #Do nothing here
    * )
    echo "$fake_batt_capacity" > /sys/class/power_supply/battery/capacity
    ;;
esac
