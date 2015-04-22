#! /usr/bin/env ruby

require 'octokit'

Octokit.auto_paginate = true

client = Octokit::Client.new(:netrc => true)

org = 'aodn'

client.org_repos(org).each do |repo|

  pulls = client.pulls(repo.full_name)

  repo = Octokit::Repository.new(repo.full_name)

  pulls.each do |pull|

    project = repo.slug
    url = pull.html_url
    updated_at = pull.updated_at

    author = pull.user.login
    comments = client.pull_comments(repo.slug, pull.number)

    commentors = comments.map { |c| c.user.login }.uniq.sort

    puts "#{updated_at}, #{project}, #{url}, #{comments.length}, #{commentors}, #{author}"
  end
end
