#!/usr/bin/env ruby
require "json"
require "thor"
require "colorize"

TASKS_FILE = "tasks.json"

class TaskManager < Thor
  def initialize(*args)
    super
    @tasks = File.exist?(TASKS_FILE) ? JSON.parse(File.read(TASKS_FILE)) : []
  end

  desc "list", "List all tasks"
  def list
    if @tasks.empty?
      puts "No tasks were found".orange
    else
      puts "Your task list".green
      @tasks.each_with_index { |task, i| puts "#{i+1}. #{task}".blue}
    end
  end

  desc "add", "Add a task to the list"
  def add(task)
    @tasks << task 
    save_tasks
    puts "#{task} added to the list.".green
  end

  desc "remove INDEX", "Remove a task by its index"
  def remove(index)
    index = index.to_i - 1
    if index.between?(0, @tasks.length - 1)
      removed = @tasks.delete_at(index)
      save_tasks
      puts "Removed task: #{removed}".red
    else
      puts "Invalid task index.".red
    end
  end

  desc "clear", "Clears all tasks from list"
  def clear
    @tasks.clear
    save_tasks

    puts "task list has been cleared".red
  end

  private 

  def save_tasks 
    File.write(TASKS_FILE, JSON.pretty_generate(@tasks))
  end
end



TaskManager.start(ARGV)