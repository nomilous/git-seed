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




program
    .command('init')
    .description('Assemble the initial .nez_tree control file into [root]')
    .action -> GitAction.configure(

            program
            success = -> 
            error   = -> 
            notify  = (status) -> console.log status.context.bold, status.message

        ).init arguments

program
    .command('status')
    .description('Git status across all nested git repos')
    .action -> GitAction.assign(program).status arguments

program
    .command('clone')
    .description('Git clone all missing nested git repos')
    .action -> GitAction.assign(program).clone arguments

program 
    .command('commit')
    .description('Git commit across all nested repos with staged changes.')
    .action -> GitAction.assign(program).commit arguments

program
    .command('pull')
    .description('Git pull across all nested git repos.')
    .action -> GitAction.assign(program).pull arguments

program
    .command('push')
    .description('[PENDING] Git push across all nested git repos (per .git-seed)')
    .action -> GitAction.assign(program).push arguments

program
    .command('watch')
    .description('[PENDING (maybe)] Attach console to github rss feeds for all nested repos')
    .action -> GitAction.assign(program).push arguments

program.parse process.argv

if GitAction.error

    GitAction.showError()
    process.exit 1

