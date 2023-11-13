/// Provides a set of values for uploading a file (the photo system uses this).
/// When a user has selected a file and pushes the "upload files" button to start the process, it is
/// _selected_.
/// When the background process starts and uploads the file, the state changes to
/// _complete_.
/// _error_ is a state when the upload fails for any reason
/// When the upload fails more than 3 times, then the state changes to
/// exceededNumberOfRetries
/// flagging the file to not be processed anymore
library;

enum FileUploadState { selected, complete, error, exceededNumberOfRetries }
