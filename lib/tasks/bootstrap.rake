# encoding: utf-8
# 初始化开发环境(注意:原有数据和文件会被清空)
# bundle exec rake shopqi:bootstrap
namespace :shopqi do

  desc "Run all bootstrapping tasks"
  task :bootstrap do
    unless Rails.env == 'production' # 防止生产环境下执行
      FileUtils.rm_rf Rails.root.join('data')
      asset_files = Rails.root.join('data', 'public_s', 'files') # 用于保存主题附件(此目录的文件链接至data/shops中的主题)
      screenshot_files = Rails.root.join('data', 'public_s', 'theme', 'screenshots') # 用于保存主题截图
      public_asset_files = Rails.root.join('public', 's', 'files')
      public_screenshot_files = Rails.root.join('public', 's', 'theme', 'screenshots')
      FileUtils.mkdir_p asset_files
      FileUtils.mkdir_p screenshot_files
      FileUtils.ln_s asset_files, public_asset_files
      FileUtils.ln_s screenshot_files, public_screenshot_files
      Rake::Task['db:setup'].invoke # 会调用db:schema:load，而非db:migrate
    end
  end

end