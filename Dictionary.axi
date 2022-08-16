PROGRAM_NAME='Dictionary'

DEFINE_CONSTANT
volatile integer MAX_STR_LEN = 255;
volatile integer MAX_KVP_COUNT = 5;

DEFINE_TYPE
structure KeyValuePair
{
	char key[MAX_STR_LEN];
	char value[MAX_STR_LEN];
}

structure Dictionary
{
	integer index;
	KeyValuePair kvp[MAX_KVP_COUNT];
}

// ----------------------------------------------------------------------------
// Name:		dictionaryAdd
// Function:	Adds a key-value-pair to the dictionary
//
// Returns:		Integer - Returns 1 if KVP successfully added to dictionary
//						  Returns 0 if KVP cannot be added
// Example:		integer success = dictionaryAdd(dict, 'key1', 'value1')
// ----------------------------------------------------------------------------
define_function integer dictionaryAdd(Dictionary dict, char key[], char value[])
{
	stack_var integer i;
	stack_var KeyValuePair kvp;

	kvp.key = key;
	kvp.value = value;

	for(i = 1; i <= dict.index; i++)
	{
		if (dict.kvp[i].key == key)
		{
			dict.kvp[i].value = value;
			return true;
		}
	}

	if (dict.index + 1 <= MAX_KVP_COUNT)
	{
		dict.index = dict.index + 1;
		dict.kvp[dict.index] = kvp;
		return true;
	}
	return false;
}
// ----------------------------------------------------------------------------
// Name:		dictionaryRemove
// Function:	Removes a key-value-pair from the dictionary
//
// Returns:		Integer - Returns 1 if KVP successfully removed from dictionary
//						  Returns 0 if KVP does not exist in dictionary
// Example:		integer success = dictionaryRemove(dict, 'key1')
// ----------------------------------------------------------------------------
define_function integer dictionaryRemove(Dictionary dict, char key[])
{
	stack_var integer i;
	stack_var integer found;
	stack_var KeyValuePair kvp;

	found = false;
	kvp.key = '';
	kvp.value = '';

	for (i = 1; i <= dict.index; i++)
	{
		if (dict.kvp[i].key == key)
		{
			found = i;
			break;
		}
	}
	if (!found)
		return found;

	for (i = found; i < max_length_array(dict.kvp) - 1; i++)
	{
		dict.kvp[i] = dict.kvp[i+1];
	}
	dict.kvp[i] = dict.kvp[i+1];
	dict.kvp[i+1] = kvp;
	dict.index--;
	
	return found;
}
// ----------------------------------------------------------------------------
// Name:		dictionarySet
// Function:	Sets the value of a key-value-pair in the dictionary
//
// Returns:		Integer - Returns 1 if value is successfully set in KVP
//						  Returns 0 if key does not exist in dictionary
// Example:		integer success = dictionarySet(dict, 'key1', 'value2')
// ----------------------------------------------------------------------------
define_function integer dictionarySet(Dictionary dict, char key[], char value[])
{
	stack_var integer i;

	for (i = 1; i <= dict.index; i++)
	{
		if (dict.kvp[i].key == key)
		{
			dict.kvp[i].value = value;
			return true;
		}
	}
	return false;
}
// ----------------------------------------------------------------------------
// Name:		dictionaryGet
// Function:	Returns the value of a key-value-pair in the dictionary
//
// Returns:		Integer - Returns the value if key is found in dictionary
//						  Returns 0 if key does not exist in dictionary
// Example:		char value[] = dictionaryGet(dict, 'key1')
// ----------------------------------------------------------------------------
define_function char[MAX_STR_LEN] dictionaryGet(Dictionary dict, char key[])
{
	stack_var integer i;

	for (i = 1; i <= max_length_array(dict.kvp); i++)
	{
		if (dict.kvp[i].key == key)
		{
			return dict.kvp[i].value;
		}
	}
	return '';
}
// ----------------------------------------------------------------------------
// Name:		dictionaryGetIndex
// Function:	Returns the index of a key-value-pair in the dictionary
//
// Returns:		Integer - Returns the index of the KVP if it exist in the dictionary
//						  Returns 0 if key does not exist in dictionary
// Example:		integer index = dictionaryGetIndex(dict, 'key1')
// ----------------------------------------------------------------------------
define_function integer dictionaryGetIndex(Dictionary dict, char key[])
{
	stack_var integer i;

	for (i = 1; i <= dict.index; i++)
	{
		if (dict.kvp[i].key == key)
		{
			return i;
		}
	}
	return 0;
}
// ----------------------------------------------------------------------------
// Name:		dictionaryClear
// Function:	Delete all key-value-pairs in dictionary
//
// Returns:
// Example:		dictionaryClear(dict)
// ----------------------------------------------------------------------------
define_function dictionaryClear(Dictionary dict)
{
	stack_var integer i;
	stack_var KeyValuePair kvp;

	kvp.key = '';
	kvp.value = '';

	for (i = 1; i <= max_length_array(dict.kvp); i++)
	{
		dict.kvp[i] = kvp;
	}
	dict.index = 0;
}
// ----------------------------------------------------------------------------
// Name:		printDictionary
// Function:	Print all key-value-pairs in dictionary
//
// Returns:
// Example:		dictionaryPrint(dict)
// ----------------------------------------------------------------------------

define_function dictionaryPrint(Dictionary dict)
{
	stack_var integer i;
	
	for (i = 1; i <= max_length_array(dict.kvp); i++)
	{
		AMX_LOG(AMX_ERROR, "'Key: ',dict.kvp[i].key,' - Value: ',dict.kvp[i].value");
	}
}
