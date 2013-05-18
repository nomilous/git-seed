program   = require 'commander'
colors    = require 'colors'
GitAction = require './git_action'

program.option '    --package-manager [package_manager]',  'Calls package manager after each clone/pull (default npm)'       
program.option '-m, --message         [commit_message]',   'Specify commit message'



#
# TODO: Scaled deployability and content distribution (proxy trees).
#

program.option '-d, --as-daemon       [config_file]',    '[NOT YET IMPLEMENTED] Run as a daemon.'
program.option '-p, --as-proxy        [config_file]',    '[NOT YET IMPLEMENTED] Run as a distribution proxy.'


noNotify = (status) -> 

    if status.cli.context == 'good'
        console.log "(#{status.cli.event})".bold.green, status.cli.detail

    else if status.cli.context == 'bad'
        console.log "(#{status.cli.event})".bold.red, status.cli.detail
        
    else 
        console.log "(#{status.cli.event})".bold, status.cli.detail


program
    .command('init')
    .description('Assemble the initial .nez_tree control file into [root]')
    .action -> 

        GitAction.configure(

            program
            success = -> 
            error   = -> 
            noNotify

        ).init arguments

program
    .command('status')
    .description('Git status across all nested git repos')
    .action -> 

        GitAction.configure(

            program
            success = -> 
            error   = -> 
            noNotify

        ).status arguments

program
    .command('clone')
    .description('Git clone all missing nested git repos')
    .action -> GitAction.assign(program).clone arguments

program 
    .command('commit')
    .description('Git commit across all nested repos with staged changes.')
    .action -> 

        GitAction.configure(

            program
            success = -> 
            error   = -> 
            noNotify

        ).commit arguments

program
    .command('pull')
    .description('Git pull across all nested git repos.')
    .action -> 

        GitAction.configure(

            program
            success = -> 
            error   = -> 
            noNotify

        ).pull arguments

program
    .command('push')
    .description('[PENDING] Git push across all nested git repos (per .git-seed)')
    .action -> 

        GitAction.configure(

            program
            success = -> 
            error   = -> 
            noNotify

        ).push arguments

program
    .command('watch')
    .description('[PENDING (maybe)] Attach console to github rss feeds for all nested repos')
    .action -> 


program.parse process.argv

if GitAction.error

    GitAction.showError()
    process.exit 1

