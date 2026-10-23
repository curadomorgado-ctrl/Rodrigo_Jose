#include "rtw_capi.h"
#ifdef HOST_CAPI_BUILD
#include "simulator_model_capi_host.h"
#define sizeof(s) ((size_t)(0xFFFF))
#undef rt_offsetof
#define rt_offsetof(s,el) ((uint16_T)(0xFFFF))
#define TARGET_CONST
#define TARGET_STRING(s) (s)
#ifndef SS_UINT64
#define SS_UINT64 17
#endif
#ifndef SS_INT64
#define SS_INT64 18
#endif
#else
#include "builtin_typeid_types.h"
#include "simulator_model.h"
#include "simulator_model_capi.h"
#include "simulator_model_private.h"
#ifdef LIGHT_WEIGHT_CAPI
#define TARGET_CONST
#define TARGET_STRING(s)               ((NULL))
#else
#define TARGET_CONST                   const
#define TARGET_STRING(s)               (s)
#endif
#endif
static const rtwCAPI_Signals rtBlockSignals [ ] = { { 0 , 1 , TARGET_STRING (
"simulator_model/MATLAB Function2" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 ,
0 } , { 1 , 0 , TARGET_STRING (
"simulator_model/MATLAB Function2/is_active_c3_simulator_model" ) ,
TARGET_STRING ( "is_active_c3_simulator_model" ) , 0 , 1 , 1 , 0 , 0 } , { 2
, 0 , TARGET_STRING ( "simulator_model/Integrator" ) , TARGET_STRING ( "" ) ,
0 , 0 , 0 , 0 , 0 } , { 3 , 0 , TARGET_STRING ( "simulator_model/Integrator1"
) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 0 , 0 , ( NULL ) , ( NULL
) , 0 , 0 , 0 , 0 , 0 } } ; static const rtwCAPI_BlockParameters
rtBlockParameters [ ] = { { 4 , TARGET_STRING ( "simulator_model/Integrator"
) , TARGET_STRING ( "InitialCondition" ) , 0 , 2 , 0 } , { 5 , TARGET_STRING
( "simulator_model/Integrator1" ) , TARGET_STRING ( "InitialCondition" ) , 0
, 2 , 0 } , { 0 , ( NULL ) , ( NULL ) , 0 , 0 , 0 } } ; static int_T
rt_LoggedStateIdxList [ ] = { - 1 } ; static const rtwCAPI_Signals
rtRootInputs [ ] = { { 0 , 0 , ( NULL ) , ( NULL ) , 0 , 0 , 0 , 0 , 0 } } ;
static const rtwCAPI_Signals rtRootOutputs [ ] = { { 0 , 0 , ( NULL ) , (
NULL ) , 0 , 0 , 0 , 0 , 0 } } ; static const rtwCAPI_ModelParameters
rtModelParameters [ ] = { { 6 , TARGET_STRING ( "Fv" ) , 0 , 1 , 0 } , { 7 ,
TARGET_STRING ( "I1" ) , 0 , 1 , 0 } , { 8 , TARGET_STRING ( "I2" ) , 0 , 1 ,
0 } , { 9 , TARGET_STRING ( "Tc" ) , 0 , 2 , 0 } , { 10 , TARGET_STRING (
"Te" ) , 0 , 2 , 0 } , { 11 , TARGET_STRING ( "g" ) , 0 , 1 , 0 } , { 12 ,
TARGET_STRING ( "l1" ) , 0 , 1 , 0 } , { 13 , TARGET_STRING ( "l2" ) , 0 , 1
, 0 } , { 14 , TARGET_STRING ( "lc1" ) , 0 , 1 , 0 } , { 15 , TARGET_STRING (
"lc2" ) , 0 , 1 , 0 } , { 16 , TARGET_STRING ( "m1" ) , 0 , 1 , 0 } , { 17 ,
TARGET_STRING ( "m2" ) , 0 , 1 , 0 } , { 0 , ( NULL ) , 0 , 0 , 0 } } ;
#ifndef HOST_CAPI_BUILD
static void * rtDataAddrMap [ ] = { & rtB . ox0mvxlaph [ 0 ] , & rtDW .
eor2gbd5fn , & rtB . ofxv15zkug [ 0 ] , & rtB . evlqsg43h4 [ 0 ] , & rtP .
Integrator_IC [ 0 ] , & rtP . Integrator1_IC [ 0 ] , & rtP . Fv , & rtP . I1
, & rtP . I2 , & rtP . Tc [ 0 ] , & rtP . Te [ 0 ] , & rtP . g , & rtP . l1 ,
& rtP . l2 , & rtP . lc1 , & rtP . lc2 , & rtP . m1 , & rtP . m2 , } ; static
int32_T * rtVarDimsAddrMap [ ] = { ( NULL ) } ;
#endif
static TARGET_CONST rtwCAPI_DataTypeMap rtDataTypeMap [ ] = { { "double" ,
"real_T" , 0 , 0 , sizeof ( real_T ) , ( uint8_T ) SS_DOUBLE , 0 , 0 , 0 } ,
{ "unsigned char" , "uint8_T" , 0 , 0 , sizeof ( uint8_T ) , ( uint8_T )
SS_UINT8 , 0 , 0 , 0 } } ;
#ifdef HOST_CAPI_BUILD
#undef sizeof
#endif
static TARGET_CONST rtwCAPI_ElementMap rtElementMap [ ] = { { ( NULL ) , 0 ,
0 , 0 , 0 } , } ; static const rtwCAPI_DimensionMap rtDimensionMap [ ] = { {
rtwCAPI_MATRIX_COL_MAJOR , 0 , 2 , 0 } , { rtwCAPI_SCALAR , 2 , 2 , 0 } , {
rtwCAPI_VECTOR , 0 , 2 , 0 } } ; static const uint_T rtDimensionArray [ ] = {
2 , 1 , 1 , 1 } ; static const real_T rtcapiStoredFloats [ ] = { 0.0 } ;
static const rtwCAPI_FixPtMap rtFixPtMap [ ] = { { ( NULL ) , ( NULL ) ,
rtwCAPI_FIX_RESERVED , 0 , 0 , ( boolean_T ) 0 } , } ; static const
rtwCAPI_SampleTimeMap rtSampleTimeMap [ ] = { { ( const void * ) &
rtcapiStoredFloats [ 0 ] , ( const void * ) & rtcapiStoredFloats [ 0 ] , (
int8_T ) 0 , ( uint8_T ) 0 } } ; static rtwCAPI_ModelMappingStaticInfo
mmiStatic = { { rtBlockSignals , 4 , rtRootInputs , 0 , rtRootOutputs , 0 } ,
{ rtBlockParameters , 2 , rtModelParameters , 12 } , { ( NULL ) , 0 } , {
rtDataTypeMap , rtDimensionMap , rtFixPtMap , rtElementMap , rtSampleTimeMap
, rtDimensionArray } , "float" , { 392974428U , 339217431U , 513453536U ,
4115420607U } , ( NULL ) , 0 , ( boolean_T ) 0 , rt_LoggedStateIdxList } ;
const rtwCAPI_ModelMappingStaticInfo * simulator_model_GetCAPIStaticMap (
void ) { return & mmiStatic ; }
#ifndef HOST_CAPI_BUILD
void simulator_model_InitializeDataMapInfo ( void ) { rtwCAPI_SetVersion ( (
* rt_dataMapInfoPtr ) . mmi , 1 ) ; rtwCAPI_SetStaticMap ( ( *
rt_dataMapInfoPtr ) . mmi , & mmiStatic ) ; rtwCAPI_SetLoggingStaticMap ( ( *
rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ; rtwCAPI_SetDataAddressMap ( ( *
rt_dataMapInfoPtr ) . mmi , rtDataAddrMap ) ; rtwCAPI_SetVarDimsAddressMap (
( * rt_dataMapInfoPtr ) . mmi , rtVarDimsAddrMap ) ;
rtwCAPI_SetInstanceLoggingInfo ( ( * rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArray ( ( * rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( ( * rt_dataMapInfoPtr ) . mmi , 0 ) ; }
#else
#ifdef __cplusplus
extern "C" {
#endif
void simulator_model_host_InitializeDataMapInfo (
simulator_model_host_DataMapInfo_T * dataMap , const char * path ) {
rtwCAPI_SetVersion ( dataMap -> mmi , 1 ) ; rtwCAPI_SetStaticMap ( dataMap ->
mmi , & mmiStatic ) ; rtwCAPI_SetDataAddressMap ( dataMap -> mmi , ( NULL ) )
; rtwCAPI_SetVarDimsAddressMap ( dataMap -> mmi , ( NULL ) ) ;
rtwCAPI_SetPath ( dataMap -> mmi , path ) ; rtwCAPI_SetFullPath ( dataMap ->
mmi , ( NULL ) ) ; rtwCAPI_SetChildMMIArray ( dataMap -> mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( dataMap -> mmi , 0 ) ; }
#ifdef __cplusplus
}
#endif
#endif
