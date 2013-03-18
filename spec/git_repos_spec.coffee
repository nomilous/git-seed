require('nez').realize 'GitRepos', (GitRepos, test, context) -> 

    context 'in CONTEXT', (does) ->

        does 'an EXPECTATION', (done) ->

            test done
