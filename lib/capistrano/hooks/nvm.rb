Capistrano::DSL.stages.each do |stage|
  after stage, 'nvm:validate'
  after stage, 'nvm:map_bins'
end
