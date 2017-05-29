// Generated by Apple Swift version 3.1 (swiftlang-802.0.53 clang-802.0.42)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if defined(__has_attribute) && __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import Foundation;
@import ObjectiveC;
@import ReactiveObjC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class OAuthAccessToken;

/// A request authenticator that can be used by Heimdallr.
SWIFT_PROTOCOL("_TtP17ReactiveHeimdallr36HeimdallResourceRequestAuthenticator_")
@protocol HeimdallResourceRequestAuthenticator
/// Authenticates the given request.
/// \param request The request to be authenticated.
///
/// \param accessToken The access token that should be used for
/// authenticating the request.
///
///
/// returns:
/// The authenticated request.
- (NSURLRequest * _Nonnull)authenticateResourceRequest:(NSURLRequest * _Nonnull)request accessToken:(OAuthAccessToken * _Nonnull)accessToken SWIFT_WARN_UNUSED_RESULT;
@end


/// A <code>HeimdallResourceRequestAuthenticator</code> which uses the HTTP <code>Authorization</code>
/// Header to authorize a request.
SWIFT_CLASS("_TtC17ReactiveHeimdallr59HeimdallResourceRequestAuthenticatorHTTPAuthorizationHeader")
@interface HeimdallResourceRequestAuthenticatorHTTPAuthorizationHeader : NSObject <HeimdallResourceRequestAuthenticator>
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
/// Authenticates the given request by setting the HTTP <code>Authorization</code>
/// header.
/// \param request The request to be authenticated.
///
/// \param accessToken The access token that should be used for
/// authenticating the request.
///
///
/// returns:
/// The authenticated request.
- (NSURLRequest * _Nonnull)authenticateResourceRequest:(NSURLRequest * _Nonnull)request accessToken:(OAuthAccessToken * _Nonnull)accessToken SWIFT_WARN_UNUSED_RESULT;
@end

@class OAuthClientCredentials;
@protocol OAuthAccessTokenStore;
@protocol OAuthAccessTokenParser;
@protocol HeimdallrHTTPClient;

/// The all-seeing and all-hearing guardian sentry of your application who
/// stands on the rainbow bridge network to authorize relevant requests.
SWIFT_CLASS("_TtC17ReactiveHeimdallr9Heimdallr")
@interface Heimdallr : NSObject
@property (nonatomic, readonly, copy) NSURL * _Nonnull tokenURL;
/// The request authenticator that is used to authenticate requests.
@property (nonatomic, readonly, strong) id <HeimdallResourceRequestAuthenticator> _Nonnull resourceRequestAuthenticator;
/// Returns a Bool indicating whether the client’s access token store
/// currently holds an access token.
/// <em>Note:</em> It’s not checked whether the stored access token, if any, has
/// already expired.
@property (nonatomic, readonly) BOOL hasAccessToken;
/// Initializes a new client.
/// \param tokenURL The token endpoint URL.
///
/// \param credentials The OAuth client credentials. If both an identifier
/// and a secret are set, client authentication is performed via HTTP
/// Basic Authentication. Otherwise, if only an identifier is set, it is
/// encoded as parameter. Default: <code>nil</code> (unauthenticated client).
///
/// \param accessTokenStore The (persistent) access token store.
/// Default: <code>OAuthAccessTokenKeychainStore</code>.
///
/// \param accessTokenParser The access token response parser.
/// Default: <code>OAuthAccessTokenDefaultParser</code>.
///
/// \param httpClient The HTTP client that should be used for requesting
/// access tokens. Default: <code>HeimdallrHTTPClientURLSession</code>.
///
/// \param resourceRequestAuthenticator The request authenticator that is
/// used to authenticate requests. Default:
/// <code>HeimdallResourceRequestAuthenticatorHTTPAuthorizationHeader</code>.
///
///
/// returns:
/// A new client initialized with the given token endpoint URL,
/// credentials and access token store.
- (nonnull instancetype)initWithTokenURL:(NSURL * _Nonnull)tokenURL credentials:(OAuthClientCredentials * _Nullable)credentials accessTokenStore:(id <OAuthAccessTokenStore> _Nonnull)accessTokenStore accessTokenParser:(id <OAuthAccessTokenParser> _Nonnull)accessTokenParser httpClient:(id <HeimdallrHTTPClient> _Nonnull)httpClient resourceRequestAuthenticator:(id <HeimdallResourceRequestAuthenticator> _Nonnull)resourceRequestAuthenticator OBJC_DESIGNATED_INITIALIZER;
/// Invalidates the currently stored access token, if any.
/// Unlike <code>clearAccessToken</code> this will only invalidate the access token so
/// that Heimdallr will try to refresh the token using the refresh token
/// automatically.
/// <em>Note:</em> Sets the access token’s expiration date to
/// 1 January 1970, GMT.
- (void)invalidateAccessToken;
/// Clears the currently stored access token, if any.
/// After calling this method the user needs to reauthenticate using
/// <code>requestAccessToken</code>.
- (void)clearAccessToken;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

@class RACUnit;
@class NSDictionary;
@class NSURLRequest;

@interface Heimdallr (SWIFT_EXTENSION(ReactiveHeimdallr))
/// Requests an access token with the resource owner’s password credentials.
/// \param username The resource owner’s username.
///
/// \param password The resource owner’s password.
///
///
/// returns:
/// A signal that sends a <code>RACUnit</code> and completes when the
/// request finishes successfully or sends an error if the request
/// finishes with an error.
- (RACSignal<RACUnit *> * _Nonnull)rac_requestAccessTokenWithUsername:(NSString * _Nonnull)username password:(NSString * _Nonnull)password SWIFT_WARN_UNUSED_RESULT;
/// Requests an access token with the given grant type.
/// \param grantType The name of the grant type
///
/// \param parameters The required parameters for the custom grant type
///
///
/// returns:
/// A signal that sends a <code>RACUnit</code> and completes when the
/// request finishes successfully or sends an error if the request
/// finishes with an error.
- (RACSignal<RACUnit *> * _Nonnull)rac_requestAccessTokenWithGrantType:(NSString * _Nonnull)grantType parameters:(NSDictionary * _Nonnull)parameters SWIFT_WARN_UNUSED_RESULT;
/// Alters the given request by adding authentication, if possible.
/// In case of an expired access token and the presence of a refresh token,
/// automatically tries to refresh the access token.
/// note:
/// If the access token must be refreshed, network I/O is
/// performed.
/// \param request An unauthenticated NSURLRequest.
///
///
/// returns:
/// A signal that sends the authenticated request on success or
/// an error if the request could not be authenticated.
- (RACSignal<NSURLRequest *> * _Nonnull)rac_authenticateRequestWithRequest:(NSURLRequest * _Nonnull)request SWIFT_WARN_UNUSED_RESULT;
@end

@class NSURLResponse;

/// An HTTP client that can be used by Heimdallr.
SWIFT_PROTOCOL("_TtP17ReactiveHeimdallr19HeimdallrHTTPClient_")
@protocol HeimdallrHTTPClient
/// Sends the given request.
/// \param request The request to be sent.
///
/// \param completion A callback to invoke when the request completed.
///
- (void)sendRequest:(NSURLRequest * _Nonnull)request completion:(void (^ _Nonnull)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion;
@end

@class NSURLSession;

/// An HTTP client that uses URLSession.
SWIFT_CLASS("_TtC17ReactiveHeimdallr29HeimdallrHTTPClientURLSession")
@interface HeimdallrHTTPClientURLSession : NSObject <HeimdallrHTTPClient>
@property (nonatomic, readonly, strong) NSURLSession * _Nonnull urlSession;
/// Initializes a new client.
/// \param urlSession The NSURLSession to use.
/// Default: <code>URLSession(configuration: URLSessionConfiguration.defaultSessionConfiguration())</code>.
///
///
/// returns:
/// A new client using the given <code>URLSession</code>.
- (nonnull instancetype)initWithUrlSession:(NSURLSession * _Nonnull)urlSession OBJC_DESIGNATED_INITIALIZER;
/// Sends the given request.
/// \param request The request to be sent.
///
/// \param completion A callback to invoke when the request completed.
///
- (void)sendRequest:(NSURLRequest * _Nonnull)request completion:(void (^ _Nonnull)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completion;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// An access token is used for authorizing requests to the resource endpoint.
SWIFT_CLASS("_TtC17ReactiveHeimdallr16OAuthAccessToken")
@interface OAuthAccessToken : NSObject
/// The access token.
@property (nonatomic, readonly, copy) NSString * _Nonnull accessToken;
/// The acess token’s type (e.g., Bearer).
@property (nonatomic, readonly, copy) NSString * _Nonnull tokenType;
/// The access token’s expiration date.
@property (nonatomic, readonly, copy) NSDate * _Nullable expiresAt;
/// The refresh token.
@property (nonatomic, readonly, copy) NSString * _Nullable refreshToken;
/// Initializes a new access token.
/// \param accessToken The access token.
///
/// \param tokenType The access token’s type.
///
/// \param expiresAt The access token’s expiration date.
///
/// \param refreshToken The refresh token.
///
///
/// returns:
/// A new access token initialized with access token, type,
/// expiration date and refresh token.
- (nonnull instancetype)initWithAccessToken:(NSString * _Nonnull)accessToken tokenType:(NSString * _Nonnull)tokenType expiresAt:(NSDate * _Nullable)expiresAt refreshToken:(NSString * _Nullable)refreshToken OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


@interface OAuthAccessToken (SWIFT_EXTENSION(ReactiveHeimdallr))
+ (OAuthAccessToken * _Nullable)decode:(NSDictionary<NSString *, id> * _Nonnull)json SWIFT_WARN_UNUSED_RESULT;
+ (OAuthAccessToken * _Nullable)decodeWithData:(NSData * _Nonnull)data SWIFT_WARN_UNUSED_RESULT;
@end


/// An access token parser that can be used by Heimdallr.
SWIFT_PROTOCOL("_TtP17ReactiveHeimdallr22OAuthAccessTokenParser_")
@protocol OAuthAccessTokenParser
- (OAuthAccessToken * _Nullable)parseWithData:(NSData * _Nonnull)data error:(NSError * _Nullable * _Nullable)error SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_CLASS("_TtC17ReactiveHeimdallr29OAuthAccessTokenDefaultParser")
@interface OAuthAccessTokenDefaultParser : NSObject <OAuthAccessTokenParser>
- (OAuthAccessToken * _Nullable)parseWithData:(NSData * _Nonnull)data error:(NSError * _Nullable * _Nullable)error SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


/// A (persistent) access token store.
SWIFT_PROTOCOL("_TtP17ReactiveHeimdallr21OAuthAccessTokenStore_")
@protocol OAuthAccessTokenStore
/// Stores the given access token.
/// Given nil, it resets the currently stored access token, if any.
/// \param accessToken The access token to be stored.
///
- (void)storeAccessToken:(OAuthAccessToken * _Nullable)accessToken;
/// Retrieves the currently stored access token.
///
/// returns:
/// The currently stored access token.
- (OAuthAccessToken * _Nullable)retrieveAccessToken SWIFT_WARN_UNUSED_RESULT;
@end


/// A persistent keychain-based access token store.
SWIFT_CLASS("_TtC17ReactiveHeimdallr29OAuthAccessTokenKeychainStore")
@interface OAuthAccessTokenKeychainStore : NSObject <OAuthAccessTokenStore>
/// Creates an instance initialized to the given keychain service.
/// \param service The keychain service.
/// Default: <code>de.rheinfabrik.heimdallr.oauth</code>.
///
- (nonnull instancetype)initWithService:(NSString * _Nonnull)service OBJC_DESIGNATED_INITIALIZER;
- (void)storeAccessToken:(OAuthAccessToken * _Nullable)accessToken;
- (OAuthAccessToken * _Nullable)retrieveAccessToken SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end




/// Client credentials are used for authenticating with the token endpoint.
SWIFT_CLASS("_TtC17ReactiveHeimdallr22OAuthClientCredentials")
@interface OAuthClientCredentials : NSObject
/// The client identifier.
@property (nonatomic, readonly, copy) NSString * _Nonnull id;
/// The client secret.
@property (nonatomic, readonly, copy) NSString * _Nullable secret;
/// Returns the client credentials as paramters.
/// Includes the client identifier as <code>client_id</code> and the client secret,
/// if set, as <code>client_secret</code>.
@property (nonatomic, readonly, copy) NSDictionary<NSString *, NSString *> * _Nonnull parameters;
/// Initializes new client credentials.
/// \param id The client identifier.
///
/// \param secret The client secret.
///
///
/// returns:
/// New client credentials initialized with the given client
/// identifier and secret.
- (nonnull instancetype)initWithId:(NSString * _Nonnull)id secret:(NSString * _Nullable)secret OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

#pragma clang diagnostic pop