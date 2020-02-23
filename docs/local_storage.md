# Local Storage
What data should be saved? Currently, I am thinking of saving the past history and current habit. 
The structure is not complicated. There aren't that many data to save and it also allows me to backup the data as well. Simply encode it into base64 and decode it when user put it back.

~~~json
{
    "history": [
        {
            "name": "playing piano",
            "percentage": 1.0,
            "completed": true
        },
        {
            "name": "drawing",
            "percentage": 0.86,
            "completed": false
        }
    ],
    "current": {
        "name": "programming",
        "length": 60,
        "progress": 5,
        "date": "22/02/2020"
    }
}
~~~