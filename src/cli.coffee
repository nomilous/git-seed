program   = require 'commander'
colors    = require 'colors'
GitAction = require './git_action'

notice    = require 'notice'
notice.configure
    source: 'git-seed'
    messenger: require 'notice-cli'


program.option '    --package-manager [package_manager]',  'Calls package manager after each clone/pull (default npm)'       
program.option '-m, --message         [commit_message]',   'Specify commit message'



#
# TODO: Scaled deployability and content distribution (proxy trees).
#

program.option '-d, --as-daemon       [config_file]',    '[NOT YET IMPLEMENTED] Run as a daemon.'
program.option '-p, --as-proxy        [config_file]',    '[NOT YET IMPLEMENTED] Run as a distribution proxy.'


try 

    #
    # facilities for personal notification routing / console output preferences
    # 

    onNotify  = require('my_notifiers').gitSeed.onNotify
    onError   = require('my_notifiers').gitSeed.onError
    onSuccess = require('my_notifiers').gitSeed.onSuccess

    #
    # note: 'my_notifiers' does not exist (as far as i know / yet) 
    #       
    #       but that does not mean the package can't be defined 
    #       globally locally, and implement:
    # 
    #       module.exports = 
    # 
    #           gitSeed: 
    # 
    #               onSuccess: (result) -> 
    #                   # 
    #                   # whatever 
    #                   # 
    # 
    #               onError: (reason) -> 
    #          
    #                   # 
    #                   # whatever 
    #                   # 
    # 
    #               onNotify: (status) -> 
    #                   # 
    #                   # whatever 
    #                   # 
    # 

catch error

    #
    # or it just prints to console
    # (without much care for console configuration incompatabilities)
    # 

    onSuccess = (result) -> 
    onError   = (reason) -> 
    onNotify  = (status) -> 

        if status.cli.context == 'good'
            console.log "(#{status.cli.event})".green, status.cli.detail

        else if status.cli.event == 'output'
            console.log status.cli.detail

        else if status.cli.context == 'bad'
            console.log "(#{status.cli.event})".bold.red, status.cli.detail

        else 
            console.log "[#{status.cli.event}]", status.cli.detail


program
    .command('init')
    .description('Assemble the initial .nez_tree control file into [root]')
    .action -> 

        GitAction.configure(

            program
            onSuccess
            onError
            notice

        ).init arguments

program
    .command('status')
    .description('Git status across all nested git repos')
    .action -> 

        GitAction.configure(

            program
            onSuccess
            onError
            notice

        ).status arguments

program
    .command('clone')
    .description('Git clone all missing nested git repos')
    .action -> 

        GitAction.configure(

            program
            onSuccess
            onError
            notice

        ).clone arguments

program 
    .command('commit')
    .description('Git commit across all nested repos with staged changes.')
    .action -> 

        GitAction.configure(

            program
            onSuccess
            onError
            notice

        ).commit arguments

program
    .command('pull')
    .description('Git pull across all nested git repos.')
    .action -> 

        GitAction.configure(

            program
            onSuccess
            onError
            notice

        ).pull arguments

program
    .command('push')
    .description('[PENDING] Git push across all nested git repos (per .git-seed)')
    .action -> 

        GitAction.configure(

            program
            onSuccess
            onError
            notice

        ).push arguments

program
    .command('watch')
    .description('[PENDING (maybe)] Attach console to github rss feeds for all nested repos')
    .action -> 


program.parse process.argv

if GitAction.error

    GitAction.showError()
    process.exit 1

