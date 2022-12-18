
/// Error types are defined in [ApiErrorTypes] as they will return from internet actions.
enum ApiErrorTypes{
  invalidValue,
  dataNotFound,
  logicalError,
  authorizationError,  
  expiredRefreshToken, 
  jwtError,
  successfuly,
  serverError,
  timeoutError,
  joiError
}