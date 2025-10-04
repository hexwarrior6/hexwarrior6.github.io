# 在 Jekyll 处理文章（post）时，自动从文件名中提取关键部分，动态设置 media_subpath 字段，无需手动在 _config.yml 中配置。
# 该插件会在文章渲染前触发，根据文章文件名（不含扩展名），提取日期+标题部分（如 2023-10-15-hello-world），
# 并将其作为 media_subpath 字段的值，用于在文章中引用图片等媒体资源时，自动添加正确的路径前缀

Jekyll::Hooks.register :posts, :pre_render do |post|
  # 获取文件名（不含扩展名）
  filename = File.basename(post.path, ".*")
  # 提取日期+标题部分（适用于 posts，格式为 YYYY-MM-DD-title）
  # 若为 drafts 或其他集合，可调整正则匹配规则
  if filename =~ /(\d{4}-\d{2}-\d{2}-.+)/
    post.data["media_subpath"] = "/assets/img/posts/#{Regexp.last_match(1)}"
  end
end
