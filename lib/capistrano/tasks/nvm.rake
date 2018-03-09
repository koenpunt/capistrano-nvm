namespace :nvm do
  task validate: :'nvm:wrapper' do
    on release_roles(fetch(:nvm_roles)) do
      nvm_node = fetch(:nvm_node)
      if nvm_node.nil?
        error 'nvm: nvm_node is not set'
        exit 1
      end

      nvm_node_path = fetch(:nvm_node_path)
      nvm_node_path = [nvm_node_path] unless nvm_node_path.is_a?(Array)
      nvm_verb = fetch(:nvm_verb).to_s

      unless test(nvm_node_path.map { |p| "[ -d #{p} ]" }.join(' || '))
        if nvm_verb == 'use'
          error "nvm: #{nvm_node} is not installed or not found in any of #{nvm_node_path.join(' ')}, and nvm is set to #{nvm_verb}"
          exit 1
        end
      end
    end
  end

  task :map_bins do
    SSHKit.config.default_env[:node_version] = fetch(:nvm_node).to_s
    SSHKit.config.default_env[:nvm_verb] = fetch(:nvm_verb).to_s
    SSHKit.config.default_env[:nvm_home] = fetch(:nvm_home).to_s
    nvm_prefix = fetch(:nvm_prefix, -> { "#{fetch(:tmp_dir)}/#{fetch(:application)}/nvm-exec.sh" })
    fetch(:nvm_map_bins).each do |command|
      SSHKit.config.command_map.prefix[command.to_sym].unshift(nvm_prefix)
    end
  end

  task :wrapper do
    on release_roles(fetch(:nvm_roles)) do
      execute :mkdir, '-p', "#{fetch(:tmp_dir)}/#{fetch(:application)}/"
      upload! StringIO.new("#!/bin/bash -e\nsource \"#{fetch(:nvm_path)}/nvm.sh\"\nexport NVM_HOME=\"#{fetch(:nvm_home)}\"\nnvm $NVM_VERB $NODE_VERSION\nexec \"$@\""), "#{fetch(:tmp_dir)}/#{fetch(:application)}/nvm-exec.sh"
      execute :chmod, '+x', "#{fetch(:tmp_dir)}/#{fetch(:application)}/nvm-exec.sh"
    end
  end
end

Capistrano::DSL.stages.each do |stage|
  after stage, 'nvm:validate'
  after stage, 'nvm:map_bins'
end

namespace :load do
  task :defaults do
    set :nvm_path, -> {
      nvm_path = fetch(:nvm_custom_path)
      nvm_path ||= if fetch(:nvm_type, :user) == :system
                     '/usr/local/nvm'
                   else
                     '$HOME/.nvm'
      end
    }

    set :nvm_home, -> {
      nvm_home = fetch(:nvm_custom_home)
      nvm_home ||= if fetch(:nvm_type, :user) == :system
                     '/usr/local/nvm'
                   else
                     '$HOME/.nvm'
      end
    }

    set :nvm_roles, fetch(:nvm_roles, :all)
    set :nvm_node_path, -> { ["#{fetch(:nvm_path)}/#{fetch(:nvm_node)}", "#{fetch(:nvm_path)}/versions/node/#{fetch(:nvm_node)}"] }
    set :nvm_map_bins, %w(node npm yarn)
    set :nvm_verb, fetch(:nvm_verb, :use)
  end
end
