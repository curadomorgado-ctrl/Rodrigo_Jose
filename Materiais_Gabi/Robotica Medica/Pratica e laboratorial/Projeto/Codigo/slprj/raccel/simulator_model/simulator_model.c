#include "simulator_model.h"
#include "rtwtypes.h"
#include "mwmathutil.h"
#include "simulator_model_private.h"
#include "rt_logging_mmi.h"
#include "simulator_model_capi.h"
#include "simulator_model_dt.h"
extern void * CreateDiagnosticAsVoidPtr_wrapper ( const char * id , int nargs
, ... ) ; extern ssExecutionInfo gblExecutionInfo ; RTWExtModeInfo *
gblRTWExtModeInfo = NULL ; void raccelForceExtModeShutdown ( boolean_T
extModeStartPktReceived ) { if ( ! extModeStartPktReceived ) { boolean_T
stopRequested = false ; rtExtModeWaitForStartPkt ( gblRTWExtModeInfo , 2 , &
stopRequested ) ; } rtExtModeShutdown ( 2 ) ; }
#include "slsv_diagnostic_codegen_c_api.h"
#include "slsa_sim_engine.h"
#ifdef RSIM_WITH_SOLVER_MULTITASKING
boolean_T gbl_raccel_isMultitasking = 1 ;
#else
boolean_T gbl_raccel_isMultitasking = 0 ;
#endif
boolean_T gbl_raccel_tid01eq = 1 ; int_T gbl_raccel_NumST = 3 ; const char_T
* gbl_raccel_Version = "23.2 (R2023b) 01-Aug-2023" ; void
raccel_setup_MMIStateLog ( SimStruct * S ) {
#ifdef UseMMIDataLogging
rt_FillStateSigInfoFromMMI ( ssGetRTWLogInfo ( S ) , & ssGetErrorStatus ( S )
) ;
#else
UNUSED_PARAMETER ( S ) ;
#endif
} static DataMapInfo rt_dataMapInfo ; DataMapInfo * rt_dataMapInfoPtr = &
rt_dataMapInfo ; rtwCAPI_ModelMappingInfo * rt_modelMapInfoPtr = & (
rt_dataMapInfo . mmi ) ; int_T enableFcnCallFlag [ ] = { 1 , 1 , 1 } ; const
char * raccelLoadInputsAndAperiodicHitTimes ( SimStruct * S , const char *
inportFileName , int * matFileFormat ) { return rt_RAccelReadInportsMatFile (
S , inportFileName , matFileFormat ) ; }
#include "simstruc.h"
#include "fixedpoint.h"
#include "slsa_sim_engine.h"
#include "simtarget/slSimTgtSLExecSimBridge.h"
#define ovslin3hy1 (-1)
B rtB ; X rtX ; DW rtDW ; static SimStruct model_S ; SimStruct * const rtS =
& model_S ; void MdlInitialize ( void ) { rtX . o05xbue0zv [ 0 ] = rtP .
Integrator1_IC [ 0 ] ; rtX . hmbbog1o03 [ 0 ] = rtP . Integrator_IC [ 0 ] ;
rtX . o05xbue0zv [ 1 ] = rtP . Integrator1_IC [ 1 ] ; rtX . hmbbog1o03 [ 1 ]
= rtP . Integrator_IC [ 1 ] ; rtDW . eybdaflhaf = false ; rtDW . ne4kcwlgsk =
ovslin3hy1 ; } void MdlStart ( void ) { { bool externalInputIsInDatasetFormat
= false ; void * pISigstreamManager = rt_GetISigstreamManager ( rtS ) ;
rtwISigstreamManagerGetInputIsInDatasetFormat ( pISigstreamManager , &
externalInputIsInDatasetFormat ) ; if ( externalInputIsInDatasetFormat ) { }
} { { { bool isStreamoutAlreadyRegistered = false ; { sdiSignalSourceInfoU
srcInfo ; sdiLabelU loggedName = sdiGetLabelFromChars ( "Integrator1" ) ;
sdiLabelU origSigName = sdiGetLabelFromChars ( "" ) ; sdiLabelU propName =
sdiGetLabelFromChars ( "Integrator1" ) ; sdiLabelU blockPath =
sdiGetLabelFromChars ( "simulator_model/To Workspace" ) ; sdiLabelU blockSID
= sdiGetLabelFromChars ( "" ) ; sdiLabelU subPath = sdiGetLabelFromChars ( ""
) ; sdiDims sigDims ; sdiLabelU sigName = sdiGetLabelFromChars (
"Integrator1" ) ; sdiAsyncRepoDataTypeHandle hDT =
sdiAsyncRepoGetBuiltInDataTypeHandle ( DATA_TYPE_DOUBLE ) ; { sdiComplexity
sigComplexity = REAL ; sdiSampleTimeContinuity stCont =
SAMPLE_TIME_CONTINUOUS ; int_T sigDimsArray [ 2 ] = { 2 , 1 } ; sigDims .
nDims = 2 ; sigDims . dimensions = sigDimsArray ; srcInfo . numBlockPathElems
= 1 ; srcInfo . fullBlockPath = ( sdiFullBlkPathU ) & blockPath ; srcInfo .
SID = ( sdiSignalIDU ) & blockSID ; srcInfo . subPath = subPath ; srcInfo .
portIndex = 0 + 1 ; srcInfo . signalName = sigName ; srcInfo . sigSourceUUID
= 0 ; rtDW . mn521cdtfr . AQHandles = sdiStartAsyncioQueueCreation ( hDT , &
srcInfo , rt_dataMapInfo . mmi . InstanceMap . fullPath ,
"cd8d144d-dbf0-4f2f-970f-45c51f9cd318" , sigComplexity , & sigDims ,
DIMENSIONS_MODE_FIXED , stCont , "" ) ; if ( rtDW . mn521cdtfr . AQHandles )
{ sdiSetSignalSampleTimeString ( rtDW . mn521cdtfr . AQHandles , "0.01" ,
0.01 , ssGetTFinal ( rtS ) ) ; sdiSetSignalRefRate ( rtDW . mn521cdtfr .
AQHandles , 0.0 ) ; sdiSetRunStartTime ( rtDW . mn521cdtfr . AQHandles ,
ssGetTaskTime ( rtS , 1 ) ) ; sdiAsyncRepoSetSignalExportSettings ( rtDW .
mn521cdtfr . AQHandles , 1 , 0 ) ; sdiAsyncRepoSetSignalExportName ( rtDW .
mn521cdtfr . AQHandles , loggedName , origSigName , propName ) ;
sdiAsyncRepoSetBlockPathDomain ( rtDW . mn521cdtfr . AQHandles ) ;
sdiSetSignalIsFrameBased ( rtDW . mn521cdtfr . AQHandles , true ) ;
sdiCompleteAsyncioQueueCreation ( rtDW . mn521cdtfr . AQHandles , hDT , &
srcInfo ) ; } sdiFreeLabel ( sigName ) ; sdiFreeLabel ( loggedName ) ;
sdiFreeLabel ( origSigName ) ; sdiFreeLabel ( propName ) ; sdiFreeLabel (
blockPath ) ; sdiFreeLabel ( blockSID ) ; sdiFreeLabel ( subPath ) ; } } if (
! isStreamoutAlreadyRegistered ) { { sdiLabelU varName = sdiGetLabelFromChars
( "q_data" ) ; sdiRegisterWksVariable ( rtDW . mn521cdtfr . AQHandles ,
varName , "array2D" ) ; sdiFreeLabel ( varName ) ; } } } } } MdlInitialize (
) ; } void MdlOutputs ( int_T tid ) { real_T A [ 4 ] ; real_T B_p [ 2 ] ;
real_T a21 ; int32_T r1 ; int32_T r2 ; rtB . evlqsg43h4 [ 0 ] = rtX .
o05xbue0zv [ 0 ] ; rtB . evlqsg43h4 [ 1 ] = rtX . o05xbue0zv [ 1 ] ; if (
ssIsSampleHit ( rtS , 1 , 0 ) ) { { if ( rtDW . mn521cdtfr . AQHandles &&
ssGetLogOutput ( rtS ) ) { sdiWriteSignal ( rtDW . mn521cdtfr . AQHandles ,
ssGetTaskTime ( rtS , 1 ) , ( char * ) & rtB . evlqsg43h4 [ 0 ] + 0 ) ; } } }
rtB . ofxv15zkug [ 0 ] = rtX . hmbbog1o03 [ 0 ] ; rtB . ofxv15zkug [ 1 ] =
rtX . hmbbog1o03 [ 1 ] ; rtDW . ne4kcwlgsk = ovslin3hy1 ; A [ 0 ] = ( ( ( (
2.0 * rtP . m2 * rtP . l1 * rtP . lc2 * muDoubleScalarCos ( rtB . evlqsg43h4
[ 1 ] ) + rtP . l1 * rtP . l1 * rtP . m2 ) + rtP . lc1 * rtP . lc1 * rtP . m1
) + rtP . lc2 * rtP . lc2 * rtP . m2 ) + rtP . I1 ) + rtP . I2 ; A [ 2 ] = (
rtP . m2 * rtP . l1 * rtP . lc2 * muDoubleScalarCos ( rtB . evlqsg43h4 [ 1 ]
) + rtP . lc2 * rtP . lc2 * rtP . m2 ) + rtP . I2 ; A [ 1 ] = ( rtP . m2 *
rtP . l1 * rtP . lc2 * muDoubleScalarCos ( rtB . evlqsg43h4 [ 1 ] ) + rtP .
lc2 * rtP . lc2 * rtP . m2 ) + rtP . I2 ; A [ 3 ] = rtP . lc2 * rtP . lc2 *
rtP . m2 + rtP . I2 ; B_p [ 0 ] = ( ( ( rtP . Tc [ 0 ] + rtP . Te [ 0 ] ) - (
- 2.0 * rtB . ofxv15zkug [ 1 ] * rtP . l1 * rtP . lc2 * rtP . m2 *
muDoubleScalarSin ( rtB . evlqsg43h4 [ 1 ] ) * rtB . ofxv15zkug [ 0 ] + - rtB
. ofxv15zkug [ 1 ] * rtP . l1 * rtP . lc2 * rtP . m2 * muDoubleScalarSin (
rtB . evlqsg43h4 [ 1 ] ) * rtB . ofxv15zkug [ 1 ] ) ) - ( ( rtP . l1 * rtP .
m2 * muDoubleScalarCos ( rtB . evlqsg43h4 [ 0 ] ) + rtP . lc1 * rtP . m1 *
muDoubleScalarCos ( rtB . evlqsg43h4 [ 0 ] ) ) + rtP . lc2 * rtP . m2 *
muDoubleScalarCos ( rtB . evlqsg43h4 [ 0 ] + rtB . evlqsg43h4 [ 1 ] ) ) * rtP
. g ) - rtP . Fv * rtB . ofxv15zkug [ 0 ] ; B_p [ 1 ] = ( ( ( rtP . Tc [ 1 ]
+ rtP . Te [ 1 ] ) - ( rtP . l1 * rtP . lc2 * rtP . m2 * muDoubleScalarSin (
rtB . evlqsg43h4 [ 1 ] ) * ( 2.0 * rtB . ofxv15zkug [ 0 ] - rtB . ofxv15zkug
[ 1 ] ) / 2.0 * rtB . ofxv15zkug [ 0 ] + rtB . ofxv15zkug [ 0 ] * rtP . l1 *
rtP . lc2 * rtP . m2 * muDoubleScalarSin ( rtB . evlqsg43h4 [ 1 ] ) / 2.0 *
rtB . ofxv15zkug [ 1 ] ) ) - rtP . g * rtP . lc2 * rtP . m2 *
muDoubleScalarCos ( rtB . evlqsg43h4 [ 0 ] + rtB . evlqsg43h4 [ 1 ] ) ) - rtP
. Fv * rtB . ofxv15zkug [ 1 ] ; if ( muDoubleScalarAbs ( A [ 1 ] ) >
muDoubleScalarAbs ( A [ 0 ] ) ) { r1 = 1 ; r2 = 0 ; } else { r1 = 0 ; r2 = 1
; } a21 = A [ r2 ] / A [ r1 ] ; a21 = ( B_p [ r2 ] - B_p [ r1 ] * a21 ) / ( A
[ r2 + 2 ] - A [ r1 + 2 ] * a21 ) ; rtB . ox0mvxlaph [ 0 ] = ( B_p [ r1 ] - A
[ r1 + 2 ] * a21 ) / A [ r1 ] ; rtB . ox0mvxlaph [ 1 ] = a21 ;
UNUSED_PARAMETER ( tid ) ; } void MdlOutputsTID2 ( int_T tid ) {
UNUSED_PARAMETER ( tid ) ; } void MdlUpdate ( int_T tid ) { UNUSED_PARAMETER
( tid ) ; } void MdlUpdateTID2 ( int_T tid ) { UNUSED_PARAMETER ( tid ) ; }
void MdlDerivatives ( void ) { XDot * _rtXdot ; _rtXdot = ( ( XDot * )
ssGetdX ( rtS ) ) ; _rtXdot -> o05xbue0zv [ 0 ] = rtB . ofxv15zkug [ 0 ] ;
_rtXdot -> hmbbog1o03 [ 0 ] = rtB . ox0mvxlaph [ 0 ] ; _rtXdot -> o05xbue0zv
[ 1 ] = rtB . ofxv15zkug [ 1 ] ; _rtXdot -> hmbbog1o03 [ 1 ] = rtB .
ox0mvxlaph [ 1 ] ; } void MdlProjection ( void ) { } void MdlTerminate ( void
) { { if ( rtDW . mn521cdtfr . AQHandles ) { sdiTerminateStreaming ( & rtDW .
mn521cdtfr . AQHandles ) ; } } } static void
mr_simulator_model_cacheDataAsMxArray ( mxArray * destArray , mwIndex i , int
j , const void * srcData , size_t numBytes ) ; static void
mr_simulator_model_cacheDataAsMxArray ( mxArray * destArray , mwIndex i , int
j , const void * srcData , size_t numBytes ) { mxArray * newArray =
mxCreateUninitNumericMatrix ( ( size_t ) 1 , numBytes , mxUINT8_CLASS ,
mxREAL ) ; memcpy ( ( uint8_T * ) mxGetData ( newArray ) , ( const uint8_T *
) srcData , numBytes ) ; mxSetFieldByNumber ( destArray , i , j , newArray )
; } static void mr_simulator_model_restoreDataFromMxArray ( void * destData ,
const mxArray * srcArray , mwIndex i , int j , size_t numBytes ) ; static
void mr_simulator_model_restoreDataFromMxArray ( void * destData , const
mxArray * srcArray , mwIndex i , int j , size_t numBytes ) { memcpy ( (
uint8_T * ) destData , ( const uint8_T * ) mxGetData ( mxGetFieldByNumber (
srcArray , i , j ) ) , numBytes ) ; } static void
mr_simulator_model_cacheBitFieldToMxArray ( mxArray * destArray , mwIndex i ,
int j , uint_T bitVal ) ; static void
mr_simulator_model_cacheBitFieldToMxArray ( mxArray * destArray , mwIndex i ,
int j , uint_T bitVal ) { mxSetFieldByNumber ( destArray , i , j ,
mxCreateDoubleScalar ( ( real_T ) bitVal ) ) ; } static uint_T
mr_simulator_model_extractBitFieldFromMxArray ( const mxArray * srcArray ,
mwIndex i , int j , uint_T numBits ) ; static uint_T
mr_simulator_model_extractBitFieldFromMxArray ( const mxArray * srcArray ,
mwIndex i , int j , uint_T numBits ) { const uint_T varVal = ( uint_T )
mxGetScalar ( mxGetFieldByNumber ( srcArray , i , j ) ) ; return varVal & ( (
1u << numBits ) - 1u ) ; } static void
mr_simulator_model_cacheDataToMxArrayWithOffset ( mxArray * destArray ,
mwIndex i , int j , mwIndex offset , const void * srcData , size_t numBytes )
; static void mr_simulator_model_cacheDataToMxArrayWithOffset ( mxArray *
destArray , mwIndex i , int j , mwIndex offset , const void * srcData ,
size_t numBytes ) { uint8_T * varData = ( uint8_T * ) mxGetData (
mxGetFieldByNumber ( destArray , i , j ) ) ; memcpy ( ( uint8_T * ) & varData
[ offset * numBytes ] , ( const uint8_T * ) srcData , numBytes ) ; } static
void mr_simulator_model_restoreDataFromMxArrayWithOffset ( void * destData ,
const mxArray * srcArray , mwIndex i , int j , mwIndex offset , size_t
numBytes ) ; static void mr_simulator_model_restoreDataFromMxArrayWithOffset
( void * destData , const mxArray * srcArray , mwIndex i , int j , mwIndex
offset , size_t numBytes ) { const uint8_T * varData = ( const uint8_T * )
mxGetData ( mxGetFieldByNumber ( srcArray , i , j ) ) ; memcpy ( ( uint8_T *
) destData , ( const uint8_T * ) & varData [ offset * numBytes ] , numBytes )
; } static void mr_simulator_model_cacheBitFieldToCellArrayWithOffset (
mxArray * destArray , mwIndex i , int j , mwIndex offset , uint_T fieldVal )
; static void mr_simulator_model_cacheBitFieldToCellArrayWithOffset ( mxArray
* destArray , mwIndex i , int j , mwIndex offset , uint_T fieldVal ) {
mxSetCell ( mxGetFieldByNumber ( destArray , i , j ) , offset ,
mxCreateDoubleScalar ( ( real_T ) fieldVal ) ) ; } static uint_T
mr_simulator_model_extractBitFieldFromCellArrayWithOffset ( const mxArray *
srcArray , mwIndex i , int j , mwIndex offset , uint_T numBits ) ; static
uint_T mr_simulator_model_extractBitFieldFromCellArrayWithOffset ( const
mxArray * srcArray , mwIndex i , int j , mwIndex offset , uint_T numBits ) {
const uint_T fieldVal = ( uint_T ) mxGetScalar ( mxGetCell (
mxGetFieldByNumber ( srcArray , i , j ) , offset ) ) ; return fieldVal & ( (
1u << numBits ) - 1u ) ; } mxArray * mr_simulator_model_GetDWork ( ) { static
const char_T * ssDWFieldNames [ 3 ] = { "rtB" , "rtDW" , "NULL_PrevZCX" , } ;
mxArray * ssDW = mxCreateStructMatrix ( 1 , 1 , 3 , ssDWFieldNames ) ;
mr_simulator_model_cacheDataAsMxArray ( ssDW , 0 , 0 , ( const void * ) & (
rtB ) , sizeof ( rtB ) ) ; { static const char_T * rtdwDataFieldNames [ 3 ] =
{ "rtDW.ne4kcwlgsk" , "rtDW.eor2gbd5fn" , "rtDW.eybdaflhaf" , } ; mxArray *
rtdwData = mxCreateStructMatrix ( 1 , 1 , 3 , rtdwDataFieldNames ) ;
mr_simulator_model_cacheDataAsMxArray ( rtdwData , 0 , 0 , ( const void * ) &
( rtDW . ne4kcwlgsk ) , sizeof ( rtDW . ne4kcwlgsk ) ) ;
mr_simulator_model_cacheDataAsMxArray ( rtdwData , 0 , 1 , ( const void * ) &
( rtDW . eor2gbd5fn ) , sizeof ( rtDW . eor2gbd5fn ) ) ;
mr_simulator_model_cacheDataAsMxArray ( rtdwData , 0 , 2 , ( const void * ) &
( rtDW . eybdaflhaf ) , sizeof ( rtDW . eybdaflhaf ) ) ; mxSetFieldByNumber (
ssDW , 0 , 1 , rtdwData ) ; } return ssDW ; } void
mr_simulator_model_SetDWork ( const mxArray * ssDW ) { ( void ) ssDW ;
mr_simulator_model_restoreDataFromMxArray ( ( void * ) & ( rtB ) , ssDW , 0 ,
0 , sizeof ( rtB ) ) ; { const mxArray * rtdwData = mxGetFieldByNumber ( ssDW
, 0 , 1 ) ; mr_simulator_model_restoreDataFromMxArray ( ( void * ) & ( rtDW .
ne4kcwlgsk ) , rtdwData , 0 , 0 , sizeof ( rtDW . ne4kcwlgsk ) ) ;
mr_simulator_model_restoreDataFromMxArray ( ( void * ) & ( rtDW . eor2gbd5fn
) , rtdwData , 0 , 1 , sizeof ( rtDW . eor2gbd5fn ) ) ;
mr_simulator_model_restoreDataFromMxArray ( ( void * ) & ( rtDW . eybdaflhaf
) , rtdwData , 0 , 2 , sizeof ( rtDW . eybdaflhaf ) ) ; } } mxArray *
mr_simulator_model_GetSimStateDisallowedBlocks ( ) { return ( NULL ) ; } void
MdlInitializeSizes ( void ) { ssSetNumContStates ( rtS , 4 ) ;
ssSetNumPeriodicContStates ( rtS , 0 ) ; ssSetNumY ( rtS , 0 ) ; ssSetNumU (
rtS , 0 ) ; ssSetDirectFeedThrough ( rtS , 0 ) ; ssSetNumSampleTimes ( rtS ,
2 ) ; ssSetNumBlocks ( rtS , 17 ) ; ssSetNumBlockIO ( rtS , 3 ) ;
ssSetNumBlockParams ( rtS , 18 ) ; } void MdlInitializeSampleTimes ( void ) {
ssSetSampleTime ( rtS , 0 , 0.0 ) ; ssSetSampleTime ( rtS , 1 , 0.01 ) ;
ssSetOffsetTime ( rtS , 0 , 0.0 ) ; ssSetOffsetTime ( rtS , 1 , 0.0 ) ; }
void raccel_set_checksum ( ) { ssSetChecksumVal ( rtS , 0 , 392974428U ) ;
ssSetChecksumVal ( rtS , 1 , 339217431U ) ; ssSetChecksumVal ( rtS , 2 ,
513453536U ) ; ssSetChecksumVal ( rtS , 3 , 4115420607U ) ; }
#if defined(_MSC_VER)
#pragma optimize( "", off )
#endif
SimStruct * raccel_register_model ( ssExecutionInfo * executionInfo ) {
static struct _ssMdlInfo mdlInfo ; static struct _ssBlkInfo2 blkInfo2 ;
static struct _ssBlkInfoSLSize blkInfoSLSize ; rt_modelMapInfoPtr = & (
rt_dataMapInfo . mmi ) ; executionInfo -> gblObjects_ . numToFiles = 0 ;
executionInfo -> gblObjects_ . numFrFiles = 0 ; executionInfo -> gblObjects_
. numFrWksBlocks = 0 ; executionInfo -> gblObjects_ . numModelInputs = 0 ;
executionInfo -> gblObjects_ . numRootInportBlks = 0 ; executionInfo ->
gblObjects_ . inportDataTypeIdx = NULL ; executionInfo -> gblObjects_ .
inportDims = NULL ; executionInfo -> gblObjects_ . inportComplex = NULL ;
executionInfo -> gblObjects_ . inportInterpoFlag = NULL ; executionInfo ->
gblObjects_ . inportContinuous = NULL ; ( void ) memset ( ( char_T * ) rtS ,
0 , sizeof ( SimStruct ) ) ; ( void ) memset ( ( char_T * ) & mdlInfo , 0 ,
sizeof ( struct _ssMdlInfo ) ) ; ( void ) memset ( ( char_T * ) & blkInfo2 ,
0 , sizeof ( struct _ssBlkInfo2 ) ) ; ( void ) memset ( ( char_T * ) &
blkInfoSLSize , 0 , sizeof ( struct _ssBlkInfoSLSize ) ) ; ssSetBlkInfo2Ptr (
rtS , & blkInfo2 ) ; ssSetBlkInfoSLSizePtr ( rtS , & blkInfoSLSize ) ;
ssSetMdlInfoPtr ( rtS , & mdlInfo ) ; ssSetExecutionInfo ( rtS ,
executionInfo ) ; slsaAllocOPModelData ( rtS ) ; { static time_T mdlPeriod [
NSAMPLE_TIMES ] ; static time_T mdlOffset [ NSAMPLE_TIMES ] ; static time_T
mdlTaskTimes [ NSAMPLE_TIMES ] ; static int_T mdlTsMap [ NSAMPLE_TIMES ] ;
static int_T mdlSampleHits [ NSAMPLE_TIMES ] ; static boolean_T
mdlTNextWasAdjustedPtr [ NSAMPLE_TIMES ] ; static int_T mdlPerTaskSampleHits
[ NSAMPLE_TIMES * NSAMPLE_TIMES ] ; static time_T mdlTimeOfNextSampleHit [
NSAMPLE_TIMES ] ; { int_T i ; for ( i = 0 ; i < NSAMPLE_TIMES ; i ++ ) {
mdlPeriod [ i ] = 0.0 ; mdlOffset [ i ] = 0.0 ; mdlTaskTimes [ i ] = 0.0 ;
mdlTsMap [ i ] = i ; mdlSampleHits [ i ] = 1 ; } } ssSetSampleTimePtr ( rtS ,
& mdlPeriod [ 0 ] ) ; ssSetOffsetTimePtr ( rtS , & mdlOffset [ 0 ] ) ;
ssSetSampleTimeTaskIDPtr ( rtS , & mdlTsMap [ 0 ] ) ; ssSetTPtr ( rtS , &
mdlTaskTimes [ 0 ] ) ; ssSetSampleHitPtr ( rtS , & mdlSampleHits [ 0 ] ) ;
ssSetTNextWasAdjustedPtr ( rtS , & mdlTNextWasAdjustedPtr [ 0 ] ) ;
ssSetPerTaskSampleHitsPtr ( rtS , & mdlPerTaskSampleHits [ 0 ] ) ;
ssSetTimeOfNextSampleHitPtr ( rtS , & mdlTimeOfNextSampleHit [ 0 ] ) ; }
ssSetSolverMode ( rtS , SOLVER_MODE_SINGLETASKING ) ; { ssSetBlockIO ( rtS ,
( ( void * ) & rtB ) ) ; ( void ) memset ( ( ( void * ) & rtB ) , 0 , sizeof
( B ) ) ; } { real_T * x = ( real_T * ) & rtX ; ssSetContStates ( rtS , x ) ;
( void ) memset ( ( void * ) x , 0 , sizeof ( X ) ) ; } { void * dwork = (
void * ) & rtDW ; ssSetRootDWork ( rtS , dwork ) ; ( void ) memset ( dwork ,
0 , sizeof ( DW ) ) ; } { static DataTypeTransInfo dtInfo ; ( void ) memset (
( char_T * ) & dtInfo , 0 , sizeof ( dtInfo ) ) ; ssSetModelMappingInfo ( rtS
, & dtInfo ) ; dtInfo . numDataTypes = 23 ; dtInfo . dataTypeSizes = &
rtDataTypeSizes [ 0 ] ; dtInfo . dataTypeNames = & rtDataTypeNames [ 0 ] ;
dtInfo . BTransTable = & rtBTransTable ; dtInfo . PTransTable = &
rtPTransTable ; dtInfo . dataTypeInfoTable = rtDataTypeInfoTable ; }
simulator_model_InitializeDataMapInfo ( ) ; ssSetIsRapidAcceleratorActive (
rtS , true ) ; ssSetRootSS ( rtS , rtS ) ; ssSetVersion ( rtS ,
SIMSTRUCT_VERSION_LEVEL2 ) ; ssSetModelName ( rtS , "simulator_model" ) ;
ssSetPath ( rtS , "simulator_model" ) ; ssSetTStart ( rtS , 0.0 ) ;
ssSetTFinal ( rtS , 5.0 ) ; ssSetStepSize ( rtS , 0.01 ) ; ssSetFixedStepSize
( rtS , 0.01 ) ; { static RTWLogInfo rt_DataLoggingInfo ; rt_DataLoggingInfo
. loggingInterval = ( NULL ) ; ssSetRTWLogInfo ( rtS , & rt_DataLoggingInfo )
; } { { static int_T rt_LoggedStateWidths [ ] = { 2 , 2 } ; static int_T
rt_LoggedStateNumDimensions [ ] = { 1 , 1 } ; static int_T
rt_LoggedStateDimensions [ ] = { 2 , 2 } ; static boolean_T
rt_LoggedStateIsVarDims [ ] = { 0 , 0 } ; static BuiltInDTypeId
rt_LoggedStateDataTypeIds [ ] = { SS_DOUBLE , SS_DOUBLE } ; static int_T
rt_LoggedStateComplexSignals [ ] = { 0 , 0 } ; static RTWPreprocessingFcnPtr
rt_LoggingStatePreprocessingFcnPtrs [ ] = { ( NULL ) , ( NULL ) } ; static
const char_T * rt_LoggedStateLabels [ ] = { "CSTATE" , "CSTATE" } ; static
const char_T * rt_LoggedStateBlockNames [ ] = { "simulator_model/Integrator1"
, "simulator_model/Integrator" } ; static const char_T * rt_LoggedStateNames
[ ] = { "" , "" } ; static boolean_T rt_LoggedStateCrossMdlRef [ ] = { 0 , 0
} ; static RTWLogDataTypeConvert rt_RTWLogDataTypeConvert [ ] = { { 0 ,
SS_DOUBLE , SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 , 0.0 } , { 0 , SS_DOUBLE ,
SS_DOUBLE , 0 , 0 , 0 , 1.0 , 0 , 0.0 } } ; static int_T
rt_LoggedStateIdxList [ ] = { 0 , 1 } ; static RTWLogSignalInfo
rt_LoggedStateSignalInfo = { 2 , rt_LoggedStateWidths ,
rt_LoggedStateNumDimensions , rt_LoggedStateDimensions ,
rt_LoggedStateIsVarDims , ( NULL ) , ( NULL ) , rt_LoggedStateDataTypeIds ,
rt_LoggedStateComplexSignals , ( NULL ) , rt_LoggingStatePreprocessingFcnPtrs
, { rt_LoggedStateLabels } , ( NULL ) , ( NULL ) , ( NULL ) , {
rt_LoggedStateBlockNames } , { rt_LoggedStateNames } ,
rt_LoggedStateCrossMdlRef , rt_RTWLogDataTypeConvert , rt_LoggedStateIdxList
} ; static void * rt_LoggedStateSignalPtrs [ 2 ] ; rtliSetLogXSignalPtrs (
ssGetRTWLogInfo ( rtS ) , ( LogSignalPtrsType ) rt_LoggedStateSignalPtrs ) ;
rtliSetLogXSignalInfo ( ssGetRTWLogInfo ( rtS ) , & rt_LoggedStateSignalInfo
) ; rt_LoggedStateSignalPtrs [ 0 ] = ( void * ) & rtX . o05xbue0zv [ 0 ] ;
rt_LoggedStateSignalPtrs [ 1 ] = ( void * ) & rtX . hmbbog1o03 [ 0 ] ; }
rtliSetLogT ( ssGetRTWLogInfo ( rtS ) , "tout" ) ; rtliSetLogX (
ssGetRTWLogInfo ( rtS ) , "" ) ; rtliSetLogXFinal ( ssGetRTWLogInfo ( rtS ) ,
"xFinal" ) ; rtliSetLogVarNameModifier ( ssGetRTWLogInfo ( rtS ) , "none" ) ;
rtliSetLogFormat ( ssGetRTWLogInfo ( rtS ) , 4 ) ; rtliSetLogMaxRows (
ssGetRTWLogInfo ( rtS ) , 0 ) ; rtliSetLogDecimation ( ssGetRTWLogInfo ( rtS
) , 1 ) ; rtliSetLogY ( ssGetRTWLogInfo ( rtS ) , "" ) ;
rtliSetLogYSignalInfo ( ssGetRTWLogInfo ( rtS ) , ( NULL ) ) ;
rtliSetLogYSignalPtrs ( ssGetRTWLogInfo ( rtS ) , ( NULL ) ) ; } { static
struct _ssStatesInfo2 statesInfo2 ; ssSetStatesInfo2 ( rtS , & statesInfo2 )
; } { static ssPeriodicStatesInfo periodicStatesInfo ;
ssSetPeriodicStatesInfo ( rtS , & periodicStatesInfo ) ; } { static
ssJacobianPerturbationBounds jacobianPerturbationBounds ;
ssSetJacobianPerturbationBounds ( rtS , & jacobianPerturbationBounds ) ; } {
static ssSolverInfo slvrInfo ; static boolean_T contStatesDisabled [ 4 ] ;
ssSetNumNonContDerivSigInfos ( rtS , 0 ) ; ssSetNonContDerivSigInfos ( rtS ,
( NULL ) ) ; ssSetSolverInfo ( rtS , & slvrInfo ) ; ssSetSolverName ( rtS ,
"ode4" ) ; ssSetVariableStepSolver ( rtS , 0 ) ;
ssSetSolverConsistencyChecking ( rtS , 0 ) ; ssSetSolverAdaptiveZcDetection (
rtS , 0 ) ; ssSetSolverRobustResetMethod ( rtS , 0 ) ;
ssSetSolverStateProjection ( rtS , 0 ) ; ssSetSolverMassMatrixType ( rtS , (
ssMatrixType ) 0 ) ; ssSetSolverMassMatrixNzMax ( rtS , 0 ) ;
ssSetModelOutputs ( rtS , MdlOutputs ) ; ssSetModelUpdate ( rtS , MdlUpdate )
; ssSetModelDerivatives ( rtS , MdlDerivatives ) ; ssSetTNextTid ( rtS ,
INT_MIN ) ; ssSetTNext ( rtS , rtMinusInf ) ; ssSetSolverNeedsReset ( rtS ) ;
ssSetNumNonsampledZCs ( rtS , 0 ) ; ssSetContStateDisabled ( rtS ,
contStatesDisabled ) ; } ssSetChecksumVal ( rtS , 0 , 392974428U ) ;
ssSetChecksumVal ( rtS , 1 , 339217431U ) ; ssSetChecksumVal ( rtS , 2 ,
513453536U ) ; ssSetChecksumVal ( rtS , 3 , 4115420607U ) ; { static const
sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE ; static RTWExtModeInfo
rt_ExtModeInfo ; static const sysRanDType * systemRan [ 2 ] ;
gblRTWExtModeInfo = & rt_ExtModeInfo ; ssSetRTWExtModeInfo ( rtS , &
rt_ExtModeInfo ) ; rteiSetSubSystemActiveVectorAddresses ( & rt_ExtModeInfo ,
systemRan ) ; systemRan [ 0 ] = & rtAlwaysEnabled ; systemRan [ 1 ] = &
rtAlwaysEnabled ; rteiSetModelMappingInfoPtr ( ssGetRTWExtModeInfo ( rtS ) ,
& ssGetModelMappingInfo ( rtS ) ) ; rteiSetChecksumsPtr ( ssGetRTWExtModeInfo
( rtS ) , ssGetChecksums ( rtS ) ) ; rteiSetTPtr ( ssGetRTWExtModeInfo ( rtS
) , ssGetTPtr ( rtS ) ) ; } slsaDisallowedBlocksForSimTargetOP ( rtS ,
mr_simulator_model_GetSimStateDisallowedBlocks ) ;
slsaGetWorkFcnForSimTargetOP ( rtS , mr_simulator_model_GetDWork ) ;
slsaSetWorkFcnForSimTargetOP ( rtS , mr_simulator_model_SetDWork ) ;
rt_RapidReadMatFileAndUpdateParams ( rtS ) ; if ( ssGetErrorStatus ( rtS ) )
{ return rtS ; } return rtS ; }
#if defined(_MSC_VER)
#pragma optimize( "", on )
#endif
void MdlOutputsParameterSampleTime ( int_T tid ) { MdlOutputsTID2 ( tid ) ; }
