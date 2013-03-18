require('nez').realize 'GitRepo', (GitRepo, test, context) -> 

    context 'in CONTEXT', (does) ->

        does 'an EXPECTATION', (done) ->

            test done
