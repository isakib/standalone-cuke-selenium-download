module DownloadHelpers
  TIMEOUT = 10
  PATH    = ENV["DOWNLOAD_DIR"]

  extend self

  def downloads
    Dir[PATH+"/*"]
  end

  def download
    downloads.first
  end

  def downloaded_content
    wait_for_download
    File.read(download)
  end

  def wait_for_download
    Timeout.timeout(TIMEOUT) do
      sleep 0.1 until downloaded?
    end
  end

  def downloaded?
    !downloading? && downloads.any?
  end

  def downloading?
    #debugger
    downloads.grep(/\.part$/).any?
  end

  def clear_downloads
    FileUtils.rm_f(downloads)
  end
end

World(DownloadHelpers)

Before do
  clear_downloads
end

After do
  clear_downloads
end