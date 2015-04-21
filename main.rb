#! /usr/bin/env ruby

require 'octokit'

Octokit.auto_paginate = true

client = Octokit::Client.new(:netrc => true)

client.repos.each do |repo|
    puts repo.name
	puts repo.pulls
end

# client.org_repos('aodn').map { |r| client.pulls(r.id) }
