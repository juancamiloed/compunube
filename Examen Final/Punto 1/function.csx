#r "Newtonsoft.Json"

using System;
using System.Net;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Primitives;
using Newtonsoft.Json;

public class Root
{
    public string sentiment { get; set; }
}

public static async Task<IActionResult> Run(HttpRequest req, ILogger log)
{

    string requestBody = String.Empty;
    using (StreamReader streamReader =  new  StreamReader(req.Body))
    {
        requestBody = await streamReader.ReadToEndAsync();
    }

    Root obj = JsonConvert.DeserializeObject<Root>(requestBody);

    string sentiment = obj.sentiment;
    string value = "";

    if(sentiment == "positive")
    {
        value = "Positive";
    } 
    else if(sentiment == "negative")
    {
        value = "Negative";
    }
    else if (sentiment == "neutral") 
    {
        value = "Neutral";
    }

    return requestBody != null
        ? (ActionResult)new OkObjectResult(value)
       : new BadRequestObjectResult("Pass a sentiment score in the request body.");
}
