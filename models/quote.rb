class Quote < ActiveRecord::Base
  
  def parse_colors
    # Find colors denoted by rgb values
    text.gsub!(/(\^\d{3})/) { |s| '</span><span style="color: #' + s[1] + s[2] + s[3] + ';">' }
    # Find colors denoted by letter
    color_letter_hash = {
      '^w' => '</span><span style="color:white;">',
      '^r' => '</span><span style="color:red;">',
      '^b' => '</span><span style="color:blue;">',
      '^y' => '</span><span style="color:yellow;">',
      '^m' => '</span><span style="color:magenta;">',
      '^n' => '</span><span style="color:brown;">',
      '^p' => '</span><span style="color:purple;">',
      '^k' => '</span><span style="color:black;">',
      '^o' => '</span><span style="color:orange;">',
      '^t' => '</span><span style="color:teal;">',
      '^v' => '</span><span style="color:grey;">',
      '^g' => '</span><span style="color:green;">'
    }
    text.gsub!(/(\^[wrbymnpkotvg])/i, color_letter_hash)
    # Find color reset marker ^*
    text.gsub!(/(\^\*)/, '</span>')
    text
  end
  
  private
  
  def quote_params
    params.require(:quote).permit(:text)
  end
  
end
