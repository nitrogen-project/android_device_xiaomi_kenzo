/*
 * Copyright (c) 2017, The Linux Foundation. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * *    * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above
 *       copyright notice, this list of conditions and the following
 *       disclaimer in the documentation and/or other materials provided
 *       with the distribution.
 *     * Neither the name of The Linux Foundation nor the names of its
 *       contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
 * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#include <dlfcn.h>
#include <telephony/ril.h>
#include <utils/SystemClock.h>

#define LOG_TAG "RILP"
#include <utils/Log.h>


typedef struct {
    int requestNumber;
    void *dispatchFunction;
    void *responseFunction;
} CommandInfo;

typedef struct RequestInfo {
    int32_t token;      //this is not RIL_Token
    CommandInfo *pCI;
    struct RequestInfo *p_next;
    char cancelled;
    char local;         // responses to local commands do not go back to command process
    RIL_SOCKET_ID socket_id;
    int wasAckSent;    // Indicates whether an ack was sent earlier
} RequestInfo;



#define RIL_LIB_PATH "libril-qc-qmi-1.so"


static struct RIL_Env s_rilEnv, s_rilProxyEnv;
static RIL_RadioFunctions s_rilFuncs;
static RIL_ActivityStatsInfo s_rilActivity;

static void RIL_OnRequestComplete(RIL_Token t, RIL_Errno e,
    void *response, size_t responselen)
{
    void *responseProxy = response;
    size_t responselenProxy = responselen;

    RequestInfo *pRI = (RequestInfo *)t;
    if (pRI->pCI->requestNumber == RIL_REQUEST_GET_ACTIVITY_INFO) {
        if (response != NULL && responselen == sizeof(RIL_ActivityStatsInfo)) {
            RIL_ActivityStatsInfo *activity = (RIL_ActivityStatsInfo *)response;

            RIL_ActivityStatsInfo *activityProxy =
                (RIL_ActivityStatsInfo *)malloc(sizeof(RIL_ActivityStatsInfo));
            if (activityProxy != NULL) {
                *activityProxy = *activity;
                activityProxy->idle_mode_time_ms =
                	activity->sleep_mode_time_ms - s_rilActivity.sleep_mode_time_ms;
                activityProxy->sleep_mode_time_ms = 0;
                responseProxy = activityProxy;
            }
            s_rilActivity = *activity;
        }
    } else if (pRI->pCI->requestNumber == RIL_REQUEST_GET_CELL_INFO_LIST) {
        if (response != NULL && responselen != 0 && responselen % sizeof(RIL_CellInfo) == 0) {
            RIL_CellInfo *cellInfo = (RIL_CellInfo *)response;
            int num = responselen / sizeof(RIL_CellInfo);

            RIL_CellInfo_v12 *cellInfo12 =
                (RIL_CellInfo_v12 *)malloc(sizeof(RIL_CellInfo_v12) * num);
            if (cellInfo12 != NULL) {
                for (int i = 0; i < num; i++) {
                    cellInfo12[i].cellInfoType = cellInfo[i].cellInfoType;
                    cellInfo12[i].registered = cellInfo[i].registered;
                    cellInfo12[i].timeStampType = cellInfo[i].timeStampType;
                    cellInfo12[i].timeStamp = cellInfo[i].timeStamp;
                    switch (cellInfo12[i].cellInfoType) {
                        case RIL_CELL_INFO_TYPE_GSM:
                            cellInfo12[i].CellInfo.gsm.cellIdentityGsm.mcc =
                                cellInfo[i].CellInfo.gsm.cellIdentityGsm.mcc;
                            cellInfo12[i].CellInfo.gsm.cellIdentityGsm.mnc =
                                cellInfo[i].CellInfo.gsm.cellIdentityGsm.mnc;
                            cellInfo12[i].CellInfo.gsm.cellIdentityGsm.lac =
                                cellInfo[i].CellInfo.gsm.cellIdentityGsm.lac;
                            cellInfo12[i].CellInfo.gsm.cellIdentityGsm.cid =
                                cellInfo[i].CellInfo.gsm.cellIdentityGsm.cid;
                            cellInfo12[i].CellInfo.gsm.cellIdentityGsm.arfcn = INT_MAX;
                            cellInfo12[i].CellInfo.gsm.cellIdentityGsm.bsic = 0xff;

                            cellInfo12[i].CellInfo.gsm.signalStrengthGsm.signalStrength =
                                cellInfo[i].CellInfo.gsm.signalStrengthGsm.signalStrength;
                            cellInfo12[i].CellInfo.gsm.signalStrengthGsm.bitErrorRate =
                                cellInfo[i].CellInfo.gsm.signalStrengthGsm.bitErrorRate;
                            cellInfo12[i].CellInfo.gsm.signalStrengthGsm.timingAdvance = INT_MAX;
                            break;
                        case RIL_CELL_INFO_TYPE_CDMA:
                            cellInfo12[i].CellInfo.cdma = cellInfo[i].CellInfo.cdma;
                            break;
                        case RIL_CELL_INFO_TYPE_LTE:
                            cellInfo12[i].CellInfo.lte.cellIdentityLte.mcc =
                                cellInfo[i].CellInfo.lte.cellIdentityLte.mcc;
                            cellInfo12[i].CellInfo.lte.cellIdentityLte.mnc =
                                cellInfo[i].CellInfo.lte.cellIdentityLte.mnc;
                            cellInfo12[i].CellInfo.lte.cellIdentityLte.ci =
                                cellInfo[i].CellInfo.lte.cellIdentityLte.ci;
                            cellInfo12[i].CellInfo.lte.cellIdentityLte.pci =
                                cellInfo[i].CellInfo.lte.cellIdentityLte.pci;
                            cellInfo12[i].CellInfo.lte.cellIdentityLte.tac =
                                cellInfo[i].CellInfo.lte.cellIdentityLte.tac;
                            cellInfo12[i].CellInfo.lte.cellIdentityLte.earfcn = INT_MAX;

                            cellInfo12[i].CellInfo.lte.signalStrengthLte =
                                cellInfo[i].CellInfo.lte.signalStrengthLte;
                            break;
                        case RIL_CELL_INFO_TYPE_WCDMA:
                            cellInfo12[i].CellInfo.wcdma.cellIdentityWcdma.mcc =
                                cellInfo[i].CellInfo.wcdma.cellIdentityWcdma.mcc;
                            cellInfo12[i].CellInfo.wcdma.cellIdentityWcdma.mnc =
                                cellInfo[i].CellInfo.wcdma.cellIdentityWcdma.mnc;
                            cellInfo12[i].CellInfo.wcdma.cellIdentityWcdma.lac =
                                cellInfo[i].CellInfo.wcdma.cellIdentityWcdma.lac;
                            cellInfo12[i].CellInfo.wcdma.cellIdentityWcdma.cid =
                                cellInfo[i].CellInfo.wcdma.cellIdentityWcdma.cid;
                            cellInfo12[i].CellInfo.wcdma.cellIdentityWcdma.psc =
                                cellInfo[i].CellInfo.wcdma.cellIdentityWcdma.mcc;
                            cellInfo12[i].CellInfo.wcdma.cellIdentityWcdma.uarfcn = INT_MAX;

                            cellInfo12[i].CellInfo.wcdma.signalStrengthWcdma =
                                cellInfo[i].CellInfo.wcdma.signalStrengthWcdma;
                            break;
                        case RIL_CELL_INFO_TYPE_TD_SCDMA:
                            cellInfo12[i].CellInfo.tdscdma = cellInfo[i].CellInfo.tdscdma;
                            break;
                    }
                }
                responseProxy = cellInfo12;
                responselenProxy = sizeof(RIL_CellInfo_v12) * num;
            }
        }
    }

    s_rilEnv.OnRequestComplete(t, e, responseProxy, responselenProxy);

    if (responseProxy != response)
        free(responseProxy);
}

const RIL_RadioFunctions *RIL_Init(const struct RIL_Env *env, int argc, char **argv)
{
    void *dlHandle;
    dlHandle = dlopen(RIL_LIB_PATH, RTLD_NOW);
    if (dlHandle == NULL)
        return NULL;

    const RIL_RadioFunctions *(*rilInit)(const struct RIL_Env *, int, char **);
    rilInit =
        (const RIL_RadioFunctions *(*)(const struct RIL_Env *, int, char **))
        dlsym(dlHandle, "RIL_Init");
    if (rilInit == NULL)
        return NULL;

    s_rilEnv = *env;
    s_rilProxyEnv = *env;
    s_rilProxyEnv.OnRequestComplete = RIL_OnRequestComplete;
    s_rilActivity.sleep_mode_time_ms = 0;
    s_rilActivity.idle_mode_time_ms = 0;

    const RIL_RadioFunctions *funcs;
    funcs = rilInit(&s_rilProxyEnv, argc, argv);
    if (funcs == NULL)
        return NULL;

    s_rilFuncs = *funcs;
    s_rilFuncs.version = 12;
    return &s_rilFuncs;
}

const RIL_RadioFunctions *RIL_SAP_Init(const struct RIL_Env *env, int argc, char **argv)
{
    void *dlHandle;
    dlHandle = dlopen(RIL_LIB_PATH, RTLD_NOW);
    if (dlHandle == NULL)
        return NULL;

    const RIL_RadioFunctions *(*rilUimInit)(const struct RIL_Env *, int, char **);
    rilUimInit =
        (const RIL_RadioFunctions *(*)(const struct RIL_Env *, int, char **))
        dlsym(dlHandle, "RIL_SAP_Init");
    if (rilUimInit == NULL)
        return NULL;

    return rilUimInit(env, argc, argv);
}
