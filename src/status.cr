require "./status/*"

require "http"

module Status
  # Helper that calls `Code.from_code`
  #
  # ```
  # Status.new(418)  # => Status::Code::ImATeapot
  # Status.new(5000) # => Status::Code::Unregistered
  # ```
  def self.new(code : Int)
    Code.from_code code
  end

  # HTTP status code is between 100 and 199
  INFORMATIONAL = 1
  # HTTP status code is between 200 and 299
  SUCCESS = 2
  # HTTP status code is between 300 and 399
  REDIRECTION = 3
  # HTTP status code is between 400 and 499
  CLIENT_ERROR = 4
  # HTTP status code is between 500 and 599
  SERVER_ERROR = 5

  # Raised when the status code provided is invalid
  #
  # ```
  # Status::Code.from_code!(5000) # => raises InvalidStatusCode
  # ```
  class InvalidStatusCode < Exception; end

  # HTTP status codes as registered with IANA.
  #
  # See: [Hypertext Transfer Protocol (HTTP) Status Code Registry](http://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml)
  enum Code
    # [RFC7231, Section 6.2.1](https://tools.ietf.org/html/rfc7231#section-6.2.1)
    Continue = 100
    # [RFC7231, Section 6.2.2](https://tools.ietf.org/html/rfc7231#section-6.2.2)
    SwitchingProtocols = 101
    # [RFC2518](https://tools.ietf.org/html/rfc2518)
    Processing = 102

    # [RFC7231, Section 6.3.1](https://tools.ietf.org/html/rfc7231#section-6.3.1)
    Ok = 200
    # [RFC7231, Section 6.3.2](https://tools.ietf.org/html/rfc7231#section-6.3.2)
    Created = 201
    # [RFC7231, Section 6.3.4](https://tools.ietf.org/html/rfc7231#section-6.3.4)
    Accepted = 202
    # [RFC7231, Section 6.3.4](https://tools.ietf.org/html/rfc7231#section-6.3.4)
    NonAuthoritativeInformation = 203
    # [RFC7231, Section 6.3.5](https://tools.ietf.org/html/rfc7231#section-6.3.5)
    NoContent = 204
    # [RFC7231, Section 6.3.6](https://tools.ietf.org/html/rfc7231#section-6.3.6)
    ResetContent = 205
    # [RFC7233, Section 4.1](https://tools.ietf.org/html/rfc7233#section-4.1)
    PartialContent = 206
    # [RFC4918](https://tools.ietf.org/html/rfc4918)
    MultiStatus = 207
    # [RFC5842](https://tools.ietf.org/html/rfc5842)
    AlreadyReported = 208
    # [RFC3229](https://tools.ietf.org/html/rfc3229)
    ImUsed = 226

    # [RFC7231, Section 6.4.1](https://tools.ietf.org/html/rfc7231#section-6.4.1)
    MultipleChoices = 300
    # [RFC7231, Section 6.4.2](https://tools.ietf.org/html/rfc7231#section-6.4.2)
    MovedPermanently = 301
    # [RFC7231, Section 6.4.3](https://tools.ietf.org/html/rfc7231#section-6.4.3)
    Found = 302
    # [RFC7231, Section 6.4.4](https://tools.ietf.org/html/rfc7231#section-6.4.4)
    SeeOther = 303
    # [RFC7232, Section 4.1](https://tools.ietf.org/html/rfc7232#section-4.1)
    NotModified = 304
    # [RFC7231, Section 6.4.5](https://tools.ietf.org/html/rfc7231#section-6.4.5)
    UseProxy = 305
    # [RFC7231, Section 6.4.7](https://tools.ietf.org/html/rfc7231#section-6.4.7)
    TemporaryRedirect = 307
    # [RFC7238](https://tools.ietf.org/html/rfc7238)
    PermanentRedirect = 308

    # [RFC7231, Section 6.5.1](https://tools.ietf.org/html/rfc7231#section-6.5.1)
    BadRequest = 400
    # [RFC7235, Section 3.1](https://tools.ietf.org/html/rfc7235#section-3.1)
    Unauthorized = 401
    # [RFC7231, Section 6.5.2](https://tools.ietf.org/html/rfc7231#section-6.5.2)
    PaymentRequired = 402
    # [RFC7231, Section 6.5.2](https://tools.ietf.org/html/rfc7231#section-6.5.3)
    Forbidden = 403
    # [RFC7231, Section 6.5.2](https://tools.ietf.org/html/rfc7231#section-6.5.4)
    NotFound = 404
    # [RFC7231, Section 6.5.2](https://tools.ietf.org/html/rfc7231#section-6.5.5)
    MethodNotAllowed = 405
    # [RFC7231, Section 6.5.2](https://tools.ietf.org/html/rfc7231#section-6.5.6)
    NotAcceptable = 406
    # [RFC7235, Section 3.2](https://tools.ietf.org/html/rfc7235#section-3.2)
    ProxyAuthenticationRequired = 407
    # [RFC7231, Section 6.5.7](https://tools.ietf.org/html/rfc7231#section-6.5.7)
    RequestTimeout = 408
    # [RFC7231, Section 6.5.7](https://tools.ietf.org/html/rfc7231#section-6.5.8)
    Conflict = 409
    # [RFC7231, Section 6.5.7](https://tools.ietf.org/html/rfc7231#section-6.5.9)
    Gone = 410
    # [RFC7231, Section 6.5.7](https://tools.ietf.org/html/rfc7231#section-6.5.10)
    LengthRequired = 411
    # [RFC7232, Section 4.2](https://tools.ietf.org/html/rfc7232#section-4.2)
    PreconditionFailed = 412
    # [RFC7231, Section 6.5.11](https://tools.ietf.org/html/rfc7231#section-6.5.11)
    PayloadTooLarge = 413
    # [RFC7231, Section 6.5.11](https://tools.ietf.org/html/rfc7231#section-6.5.12)
    UriTooLong = 414
    # [RFC7231, Section 6.5.11](https://tools.ietf.org/html/rfc7231#section-6.5.13)
    UnsupportedMediaType = 415
    # [RFC7233, Section 4.4](https://tools.ietf.org/html/rfc7233#section-4.4)
    RangeNotSatisfiable = 416
    # [RFC7231, Section 6.5.14](https://tools.ietf.org/html/rfc7231#section-6.5.14)
    ExpectationFailed = 417
    # [RFC2324](https://tools.ietf.org/html/rfc2324)
    ImATeapot = 418
    # [RFC7540, Section 9.1.2](http://tools.ietf.org/html/rfc7540#section-9.1.2)
    MisdirectedRequest = 421
    # [RFC4918](https://tools.ietf.org/html/rfc4918)
    UnprocessableEntity = 422
    # [RFC4918](https://tools.ietf.org/html/rfc4918)
    Locked = 423
    # [RFC4918](https://tools.ietf.org/html/rfc4918)
    FailedDependency = 424
    # [RFC7231, Section 6.5.15](https://tools.ietf.org/html/rfc7231#section-6.5.15)
    UpgradeRequired = 426
    # [RFC6585](https://tools.ietf.org/html/rfc6585)
    PreconditionRequired = 428
    # [RFC6585](https://tools.ietf.org/html/rfc6585)
    TooManyRequests = 429
    # [RFC6585](https://tools.ietf.org/html/rfc6585)
    RequestHeaderFieldsTooLarge = 431
    # [RFC7725](http://tools.ietf.org/html/rfc7725)
    UnavailableForLegalReasons = 451

    # [RFC7231, Section 6.6.1](https://tools.ietf.org/html/rfc7231#section-6.6.1)
    InternalServerError = 500
    # [RFC7231, Section 6.6.2](https://tools.ietf.org/html/rfc7231#section-6.6.2)
    NotImplemented = 501
    # [RFC7231, Section 6.6.3](https://tools.ietf.org/html/rfc7231#section-6.6.3)
    BadGateway = 502
    # [RFC7231, Section 6.6.4](https://tools.ietf.org/html/rfc7231#section-6.6.4)
    ServiceUnavailable = 503
    # [RFC7231, Section 6.6.5](https://tools.ietf.org/html/rfc7231#section-6.6.5)
    GatewayTimeout = 504
    # [RFC7231, Section 6.6.6](https://tools.ietf.org/html/rfc7231#section-6.6.6)
    HttpVersionNotSupported = 505
    # [RFC2295](https://tools.ietf.org/html/rfc2295)
    VariantAlsoNegotiates = 506
    # [RFC4918](https://tools.ietf.org/html/rfc4918)
    InsufficientStorage = 507
    # [RFC5842](https://tools.ietf.org/html/rfc5842)
    LoopDetected = 508
    # [RFC2774](https://tools.ietf.org/html/rfc2774)
    NotExtended = 510
    # [RFC6585](https://tools.ietf.org/html/rfc6585)
    NetworkAuthenticationRequired = 511

    # A status code not in the IANA HTTP status code registry or very well known.
    Unregistered = 0

    # Returns a HTTP status code matching the value otherwise returns `Code::Unregistered`.
    #
    # ```
    # Status::Code.from_code(404)  # => Status::Code::NotFound
    # Status::Code.from_code(5000) # => Status::Code::Unregistered
    # ```
    def self.from_code(code : Int)
      case code
      when 100; Continue
      when 101; SwitchingProtocols
      when 102; Processing
      when 200; Ok
      when 201; Created
      when 202; Accepted
      when 203; NonAuthoritativeInformation
      when 204; NoContent
      when 205; ResetContent
      when 206; PartialContent
      when 207; MultiStatus
      when 208; AlreadyReported
      when 226; ImUsed
      when 300; MultipleChoices
      when 301; MovedPermanently
      when 302; Found
      when 303; SeeOther
      when 304; NotModified
      when 305; UseProxy
      when 307; TemporaryRedirect
      when 308; PermanentRedirect
      when 400; BadRequest
      when 401; Unauthorized
      when 402; PaymentRequired
      when 403; Forbidden
      when 404; NotFound
      when 405; MethodNotAllowed
      when 406; NotAcceptable
      when 407; ProxyAuthenticationRequired
      when 408; RequestTimeout
      when 409; Conflict
      when 410; Gone
      when 411; LengthRequired
      when 412; PreconditionFailed
      when 413; PayloadTooLarge
      when 414; UriTooLong
      when 415; UnsupportedMediaType
      when 416; RangeNotSatisfiable
      when 417; ExpectationFailed
      when 418; ImATeapot
      when 421; MisdirectedRequest
      when 422; UnprocessableEntity
      when 423; Locked
      when 424; FailedDependency
      when 426; UpgradeRequired
      when 428; PreconditionRequired
      when 429; TooManyRequests
      when 431; RequestHeaderFieldsTooLarge
      when 451; UnavailableForLegalReasons
      when 500; InternalServerError
      when 501; NotImplemented
      when 502; BadGateway
      when 503; ServiceUnavailable
      when 504; GatewayTimeout
      when 505; HttpVersionNotSupported
      when 506; VariantAlsoNegotiates
      when 507; InsufficientStorage
      when 508; LoopDetected
      when 510; NotExtended
      when 511; NetworkAuthenticationRequired
      else      Unregistered
      end
    end

    # Returns a HTTP status code matching the value otherwise returns `nil`.
    #
    # ```
    # Status::Code.from_code?(503)  # => Status::Code::ServiceUnavailable
    # Status::Code.from_code?(1000) # => nil
    # ```
    def self.from_code?(code : Int)
      status = self.from_code code

      status != Code::Unregistered ? status : nil
    end

    # Returns a HTTP status code matching the value otherwise raises `InvalidStatusCode` exception.
    #
    # ```
    # Status::Code.from_code!(418) # => Status::Code::ImATeapot
    # Status::Code.from_code(1000) # => raises InvalidStatusCode
    # ```
    def self.from_code!(code : Int)
      status = self.from_code code

      if status != Code::Unregistered
        status
      else
        raise InvalidStatusCode.new("#{code} is an invalid status code")
      end
    end

    # Returns whether the status code is between 100 and 199
    #
    # ```
    # Status::Code::Continue.informational? # => true
    # Status::Code::Ok.informational?       # => false
    # ```
    def informational?
      self.value / 100 == INFORMATIONAL
    end

    # Returns whether the status code is between 200 and 299
    #
    # ```
    # Status::Code::Ok.success?       # => true
    # Status::Code::Conflict.success? # => false
    # ```
    def success?
      self.value / 100 == SUCCESS
    end

    # Returns whether the status code is between 300 and 399
    #
    # ```
    # Status::Code::Found.redirection?     # => true
    # Status::Code::Forbidden.redirection? # => false
    # ```
    def redirection?
      self.value / 100 == REDIRECTION
    end

    # Returns whether the status code is between 400 and 499
    #
    # ```
    # Status::Code::MethodNotAllowed.client_error? # => true
    # Status::Code::Accepted.client_error?         # => false
    # ```
    def client_error?
      self.value / 100 == CLIENT_ERROR
    end

    # Returns whether the status code is between 500 and 599
    #
    # ```
    # Status::Code::ServiceUnavailable.server_error? # => true
    # Status::Code::Gone.server_error?               # => false
    # ```
    def server_error?
      self.value / 100 == SERVER_ERROR
    end

    # Returns the underlying integer status code.
    #
    # ```
    # Status::Code::NoContent # => 204
    # ```
    def to_i
      self.value
    end

    # Returns the canonical status message.
    #
    # ```
    # Status::Code::BadGateway # => Bad Gateway
    # ```
    def message
      HTTP.default_status_message_for self.value
    end
  end
end
