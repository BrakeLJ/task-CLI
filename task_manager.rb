#!/usr/bin/env ruby
require "json"
require "thor"

TASKS_FILE = "tasks.json"

class TaskManager < Thor
  def initialize(*args)
    super
    @tasks = File.exist?(TASKS_FILE) ? JSON.parse(File.read(TASKS_FILE)) : []
  end

  desc "list", "List all tasks"
  def list
    if @tasks.empty?
      puts "No tasks were found"
    else
      @tasks.each_with_index { |task, i| puts "#{i+1}. #{task}"}
    end
  end

  desc "add", "Add a task to the list"
  def add(task)
    @tasks << task 
    save_tasks
    puts "#{task} added to the list."
  end

  private 

  def save_tasks 
    File.write(TASKS_FILE, JSON.pretty_generate(@tasks))
  end
end



TaskManager.start(ARGV)