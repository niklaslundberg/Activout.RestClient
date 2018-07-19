﻿using System.Collections.Generic;

namespace Activout.MovieReviews
{
    public class ErrorResponse
    {
        public List<Error> Errors { get; set; }

        public class Error
        {
            public string Message { get; set; }
            public int Code { get; set; }
        }
    }
}