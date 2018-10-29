append = """
document.addEventListener('DOMContentLoaded', function() {
 $.ajax({
   url: 'https://gist.githubusercontent.com/phantummm/821952d36e99bb33a5e0d53af2263f66/raw/f624ad987bac057f60a96019b038fea0cfd873e7/dark-slack.css',
   success: function(css) {
     let overrides = `
     code { background-color: #535353; color: #85c5ff; } /* Change color: to whatever font color you want */
     .c-mrkdwn__pre, .c-mrkdwn__quote { background: #535353 !important; background-color: #535353 !important; }
     `
     $("<style></style>").appendTo('head').html(css + overrides);
   }
 });
});
"""

with open("/Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js", "a") as myfile:
    myfile.write(append)
