class Quote < ActiveRecord::Base
  validates :text, length: { minimum: 2, maximum: 160 }
  
  def parse_colors
    # Find colors denoted by rgb values
    text.gsub!(/(\^\d{3})/) { |s| '</span><span style="color: rgb(' + (s[1].to_i * 28).to_s + ',' + (s[2].to_i * 28).to_s + ',' + (s[3].to_i * 28).to_s + ');">' }
    # Find colors denoted by letter
    color_letter_hash = {
      '^w' => '</span><span style="color:white;">',
      '^W' => '</span><span style="color:white;">',
      '^r' => '</span><span style="color:red;">',
      '^R' => '</span><span style="color:red;">',
      '^b' => '</span><span style="color:blue;">',
      '^B' => '</span><span style="color:blue;">',
      '^y' => '</span><span style="color:yellow;">',
      '^Y' => '</span><span style="color:yellow;">',
      '^m' => '</span><span style="color:magenta;">',
      '^M' => '</span><span style="color:magenta;">',
      '^n' => '</span><span style="color:brown;">',
      '^N' => '</span><span style="color:brown;">',
      '^p' => '</span><span style="color:purple;">',
      '^P' => '</span><span style="color:purple;">',
      '^k' => '</span><span style="color:black;">',
      '^K' => '</span><span style="color:black;">',
      '^o' => '</span><span style="color:orange;">',
      '^O' => '</span><span style="color:orange;">',
      '^t' => '</span><span style="color:teal;">',
      '^T' => '</span><span style="color:teal;">',
      '^v' => '</span><span style="color:grey;">',
      '^V' => '</span><span style="color:grey;">',
      '^g' => '</span><span style="color:green;">',
      '^G' => '</span><span style="color:green;">'
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
