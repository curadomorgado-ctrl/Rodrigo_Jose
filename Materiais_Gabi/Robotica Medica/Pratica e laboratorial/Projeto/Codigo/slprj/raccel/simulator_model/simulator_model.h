#ifndef RTW_HEADER_simulator_model_h_
#define RTW_HEADER_simulator_model_h_
#ifndef simulator_model_COMMON_INCLUDES_
#define simulator_model_COMMON_INCLUDES_
#include <stdlib.h>
#include "sl_AsyncioQueue/AsyncioQueueCAPI.h"
#include "rtwtypes.h"
#include "sigstream_rtw.h"
#include "simtarget/slSimTgtSigstreamRTW.h"
#include "simtarget/slSimTgtSlioCoreRTW.h"
#include "simtarget/slSimTgtSlioClientsRTW.h"
#include "simtarget/slSimTgtSlioSdiRTW.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "raccel.h"
#include "slsv_diagnostic_codegen_c_api.h"
#include "rt_logging_simtarget.h"
#include "dt_info.h"
#include "ext_work.h"
#endif
#include "simulator_model_types.h"
#include <stddef.h>
#include "rtw_modelmap_simtarget.h"
#include "rt_defines.h"
#include <string.h>
#include "rt_nonfinite.h"
#define MODEL_NAME simulator_model
#define NSAMPLE_TIMES (3) 
#define NINPUTS (0)       
#define NOUTPUTS (0)     
#define NBLOCKIO (3) 
#define NUM_ZC_EVENTS (0) 
#ifndef NCSTATES
#define NCSTATES (4)   
#elif NCSTATES != 4
#error Invalid specification of NCSTATES defined in compiler command
#endif
#ifndef rtmGetDataMapInfo
#define rtmGetDataMapInfo(rtm) (*rt_dataMapInfoPtr)
#endif
#ifndef rtmSetDataMapInfo
#define rtmSetDataMapInfo(rtm, val) (rt_dataMapInfoPtr = &val)
#endif
#ifndef IN_RACCEL_MAIN
#endif
typedef struct { real_T evlqsg43h4 [ 2 ] ; real_T ofxv15zkug [ 2 ] ; real_T
ox0mvxlaph [ 2 ] ; } B ; typedef struct { struct { void * AQHandles ; }
mn521cdtfr ; int32_T ne4kcwlgsk ; uint8_T eor2gbd5fn ; boolean_T eybdaflhaf ;
} DW ; typedef struct { real_T o05xbue0zv [ 2 ] ; real_T hmbbog1o03 [ 2 ] ; }
X ; typedef struct { real_T o05xbue0zv [ 2 ] ; real_T hmbbog1o03 [ 2 ] ; }
XDot ; typedef struct { boolean_T o05xbue0zv [ 2 ] ; boolean_T hmbbog1o03 [ 2
] ; } XDis ; typedef struct { rtwCAPI_ModelMappingInfo mmi ; } DataMapInfo ;
struct P_ { real_T Fv ; real_T I1 ; real_T I2 ; real_T Tc [ 2 ] ; real_T Te [
2 ] ; real_T g ; real_T l1 ; real_T l2 ; real_T lc1 ; real_T lc2 ; real_T m1
; real_T m2 ; real_T Integrator1_IC [ 2 ] ; real_T Integrator_IC [ 2 ] ; } ;
extern const char_T * RT_MEMORY_ALLOCATION_ERROR ; extern B rtB ; extern X
rtX ; extern DW rtDW ; extern P rtP ; extern mxArray *
mr_simulator_model_GetDWork ( ) ; extern void mr_simulator_model_SetDWork (
const mxArray * ssDW ) ; extern mxArray *
mr_simulator_model_GetSimStateDisallowedBlocks ( ) ; extern const
rtwCAPI_ModelMappingStaticInfo * simulator_model_GetCAPIStaticMap ( void ) ;
extern SimStruct * const rtS ; extern DataMapInfo * rt_dataMapInfoPtr ;
extern rtwCAPI_ModelMappingInfo * rt_modelMapInfoPtr ; void MdlOutputs (
int_T tid ) ; void MdlOutputsParameterSampleTime ( int_T tid ) ; void
MdlUpdate ( int_T tid ) ; void MdlTerminate ( void ) ; void
MdlInitializeSizes ( void ) ; void MdlInitializeSampleTimes ( void ) ;
SimStruct * raccel_register_model ( ssExecutionInfo * executionInfo ) ;
#endif
