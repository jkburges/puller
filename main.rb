#! /usr/bin/env ruby

require 'octokit'

Octokit.auto_paginate = true
@client = Octokit::Client.new(:netrc => true)

org = 'aodn'

def print_stats(pull)
  pull = @client.pull(pull.base.repo.full_name, pull.number)

  project_name = pull.base.repo.full_name
  url = pull.html_url

  created_at = pull.created_at
  updated_at = pull.updated_at
  merged_at = pull.merged_at

  author = pull.user.login
  state = pull.state

  merger = pull.merged_by? ? pull.merged_by.login : nil

  review_comments = @client.pull_comments(project_name, pull.number)
  issue_comments = @client.issue_comments(project_name, pull.number)
  comments = issue_comments.concat(review_comments).uniq
  commentors = comments.map { |c| c.user.login }.uniq.sort

  puts [created_at, merged_at, updated_at, project_name, url, author, state, merger, comments.length, "#{commentors}"].join ', '
end

puts ['created_at', 'merged_at', 'updated_at', 'project_name', 'url', 'author', 'state', 'merger', 'comments.length', 'commentors'].join ','

@client.org_repos(org).each do |repo|

  pulls = @client.pulls(repo.full_name, :state => :closed)

  repo = Octokit::Repository.new(repo.full_name)

  pulls.each do |pull|
    print_stats pull
  end
end
