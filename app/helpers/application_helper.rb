module ApplicationHelper
  include Pagy::Frontend

  def split_think_value(value)
    s_val = value.to_s # Ensure it's a string

    think_open_tag = "<think>"
    think_close_tag = "</think>"

    start_open_tag_idx = s_val.index(think_open_tag)

    # Check if <think> tag exists
    return [nil, s_val] if start_open_tag_idx.nil?

    idx_after_open_tag = start_open_tag_idx + think_open_tag.length

    start_close_tag_idx = s_val.index(think_close_tag, idx_after_open_tag)

    # Check if </think> tag exists after <think>
    return [nil, s_val] if start_close_tag_idx.nil?

    # Extract think_content: content between <think> and </think>
    # The problem implies <think> is at the beginning. If it can be anywhere,
    # this logic holds, but the "result" is then everything after the *first* </think>.
    think_content = s_val[idx_after_open_tag...start_close_tag_idx].strip

    idx_after_close_tag = start_close_tag_idx + think_close_tag.length
    result = s_val[idx_after_close_tag..-1].strip

    [think_content, result]
  end

  def svg_icon(cil_name, icon_class, options = {})
    options["xlink:href"] = asset_path(cil_name)
    content_tag :svg, nil, class: icon_class do
      content_tag :use, nil, options
    end
  end

  def footer
    content_tag :footer, nil, class: "footer" do
      left_part = content_tag :div, nil do
        concat link_to "CoreUI", "https://coreui.io"
        concat " "
        concat link_to "High Five", "https://git.thape.com.cn/rails/high-five"
        concat "  © 2024 Eric-Guo."
      end
      right_part = content_tag :div, nil, class: "ms-auto" do
        concat "Powered by "
        concat link_to "CoreUI PRO UI Components", "https://coreui-doc.redwoodjs.cn/"
      end
      left_part.concat(right_part)
    end
  end
end
