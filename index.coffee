{dispatch_impl} = require 'libprotocol'
{info, warn, error, debug} = dispatch_impl 'ILogger', 'IKeyFilter'
{pubsubhub} = require 'libprotein'

proto = [
    ['on_key_pass', ['key']]
    ['filter_keys', ['key_event']]
]

impl = (node) ->
    {pub, sub} = pubsubhub()

    filter_keys: (ev) -> (pub 'passed', ev.keyCode)
    on_key_pass: (keycode, f) -> sub 'passed', (key) -> f() if key is keycode


module.exports =
    protocols:
        definitions:
            IKeyFilter: proto
        implementations:
            IKeyFilter: impl