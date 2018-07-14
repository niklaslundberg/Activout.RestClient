# Activout Rest Client
Create a REST(ish) API client only by defining the C# interface you want

*Shamelessly inspired by [Rest Client for MicroProfile](https://github.com/eclipse/microprofile-rest-client).* 

## Rationale
The Activout Rest Client provides a type-safe approach to invoke RESTful services over HTTP. As much as possible the Rest Client attempts to use .NET Core MVC APIs for consistency and easier re-use.

## Example
Here is an example - let’s say that you want to use a movie review service. The remote service might provide APIs to view users' reviews and allow you to post and modify your own reviews. You might start with an interface to represent the remote service like this:

```C#
[InterfaceRoute("movies")]
[ErrorResponse(typeof(ErrorResponse))]
[InterfaceConsumes("application/json")]
public interface IMovieReviewService
{
    [HttpGet]
    Task<IEnumerable<Movie>> GetAllMovies();

    [HttpGet]
    [Route("/{movieId}/reviews")]
    Task<IEnumerable<Review>> GetAllReviews([RouteParam("movieId")] string movieId);

    [HttpGet("/{movieId}/reviews/{reviewId}")]
    Review GetReview([RouteParam("movieId")] string movieId, [RouteParam("reviewId")] string reviewId);

    [HttpPost]
    [Route("/{movieId}/reviews")]
    Task<Review> SubmitReview([RouteParam("movieId")] string movieId, Review review);

    [HttpPut]
    [Route("/{movieId}/reviews/{reviewId}")]
    Review UpdateReview([RouteParam("movieId")] string movieId, [RouteParam("reviewId")] string reviewId, Review review);

    [HttpPost("/import.csv")]
    [Consumes("text/csv")]
    Task Import(string csv);
}
```

Now we can use this interface as a means to invoke the actual remote review service like this:

```C#
var movieReviewService = restClientFactory
            .CreateBuilder(httpClient)
            .BaseUri(new Uri("http://localhost:9080/movieReviewService"))
            .Build<IMovieReviewService>();

Review review = new Review(stars: 3, "This was a delightful comedy, but not terribly realistic.");
await movieReviewService.SubmitReview(movieId, review);
```

This allows for a much more natural coding style, and the underlying implementation handles the communication between the client and service - it makes the HTTP connection, serializes the Review object to JSON/etc. so that the remote service can process it.

## Usage notes

- Exceptions will be wrapped in AggregatedException
- Both synchronous and asynchronous calls are supported. Asynchronous is recommended.
- Additional serializers and deserializers can be added at will.
- Support for custom error objects via \[ErrorResponse\] attribute. These will be included in a RestClientException that is thrown if the API call fails.

## TODO

- Query parameters are not yet implemented

## Collaborate
This project is still under development - participation welcome!
