PROGRAM_NAME='Main'
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/05/2006  AT: 09:00:25        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
*)
#INCLUDE 'Dictionary'
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

dvMaster = 0:1:0;
(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE
Dictionary dict;
char value[255];
integer index;
(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
define_function printToDebug(char msg[])
{
	AMX_LOG(AMX_ERROR, "msg");
}
(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

	wait 100
	{
		printToDebug('Adding to Dictionary');
		dictionaryAdd(dict, 'key1', 'value1');
		dictionaryPrint(dict);

		printToDebug('Getting from Dictionary');
		value = dictionaryGet(dict, 'key1');
		printToDebug("'Value of Key1: ', value");

		printToDebug("'Adding new KVPs'");
		dictionaryAdd(dict, 'key2', 'value2');
		dictionaryAdd(dict, 'key3', 'value3');
		dictionaryAdd(dict, 'key4', 'value4');
		dictionaryAdd(dict, 'key5', 'value5');
		dictionaryAdd(dict, 'key6', 'value6');
		dictionaryPrint(dict);

		printToDebug('Setting new value');
		dictionarySet(dict, 'key2', 'new value2');
		dictionaryPrint(dict);

		printToDebug('Removing from Dictionary');
		dictionaryRemove(dict, 'key1');
		dictionaryPrint(dict);
		
		printToDebug('Removing from Dictionary');
		dictionaryRemove(dict, 'key5');
		dictionaryPrint(dict);

		printToDebug('Get Index from Dictionary');
		index = dictionaryGetIndex(dict, 'key2');
		printToDebug("'Index of Key2: ', itoa(index)");
		dictionaryPrint(dict);
		
		printToDebug('Get Index from Dictionary');
		index = dictionaryGetIndex(dict, 'keyX');
		printToDebug("'Index of KeyX: ', itoa(index)");
		dictionaryPrint(dict);
		
		printToDebug('Adding to Dictionary');
		dictionaryAdd(dict, 'key5', 'value5');
		dictionaryAdd(dict, 'key6', 'value6');
		dictionaryPrint(dict);
	}
(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT


DEFINE_PROGRAM

