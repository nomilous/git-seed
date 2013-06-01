program   = require 'commander'
colors    = require 'colors'
GitAction = require './git_action'
Notice    = require 'notice'

notice    = Notice.create 'git-seed'

notice.use (msg, next) -> 

    description = msg.context.description
    #detail      = msg.content.detail

    switch msg.context.type

        # when 'stdout'
        #     process.stdout.write msg.content.title
        #     return

        # when 'stderr'
        #     process.stderr.write msg.content.title
        #     return

        when 'event' then title = "EVENT [#{msg.context.title}]".bold
        when 'info'  then title = " info (#{msg.context.title})"
        else title = "#{msg.context.title}"

    switch msg.context.tenor

        when 'good' then title = title.green
        when 'bad' then title = title.red

    console.log "%s - %s", title.white, description
    console.log detail if detail

    next()

    # if msg.content.label == 'seed update' 
    #     console.log JSON.stringify msg.content.seed


program.option '    --package-manager [package_manager]',  'Calls package manager after each clone/pull (default npm)'       
program.option '-m, --message         [commit_message]',   'Specify commit message'


#
# TODO: Scaled deployability and content distribution (proxy trees).
#

program.option '-d, --as-daemon       [config_file]',    '[NOT YET IMPLEMENTED] Run as a daemon.'
program.option '-p, --as-proxy        [config_file]',    '[NOT YET IMPLEMENTED] Run as a distribution proxy.'


program
    .command('init')
    .description('Update the .git-seed control file')
    .action -> 

        GitAction.configure(

            program
            success = -> console.log 'DONE', arguments
            error   = -> console.log 'ERROR', arguments
            notice

        ).init arguments

program
    .command('status')
    .description('Status of all repos in the .git-seed')
    .action -> 

        GitAction.configure(

            program
            success = -> console.log 'DONE', arguments
            error   = -> console.log 'ERROR', arguments
            notice

        ).status arguments

program
    .command('clone')
    .description('Clone all missing repos in the .git-seed')
    .action -> 

        GitAction.configure(

            program
            success = -> console.log 'DONE', arguments
            error   = -> console.log 'ERROR', arguments
            notice

        ).clone arguments

program 
    .command('commit')
    .description('Commit from all repos in the .git-seed (that have staged changes)')
    .action -> 

        GitAction.configure(

            program
            success = -> console.log 'DONE', arguments
            error   = -> console.log 'ERROR', arguments
            notice

        ).commit arguments

program
    .command('pull')
    .description('Pull into all repos in the .git-seed')
    .action -> 

        GitAction.configure(

            program
            success = -> console.log 'DONE', arguments
            error   = -> console.log 'ERROR', arguments
            notice

        ).pull arguments


# program
#     .command('push')
#     .description('[PENDING] Git push across all nested git repos (per .git-seed)')
#     .action -> 
#
#         GitAction.configure(
#
#             program
#             success = -> console.log 'DONE', arguments
#             error   = -> console.log 'ERROR', arguments
#             notice
#
#         ).push arguments
# 
# program
#     .command('watch')
#     .description('[PENDING] Attach console to github rss feeds for all repos in .git-seed')
#     .action -> 
#
#         GitAction.configure(
#
#             program
#             success = -> console.log 'DONE', arguments
#             error   = -> console.log 'ERROR', arguments
#             notice
#
#         ).watch arguments


program.parse process.argv

if GitAction.error

    GitAction.showError()
    process.exit 1

