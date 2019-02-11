require "test/unit"
load "./manifest.rb"

class ChangelogTest < Test::Unit::TestCase

    def test_pack_unpack()
        # test pack and unpack
        str1 = Digest::SHA1.digest('')
        strH = str1.unpack('H*').first
        str2 = [strH].pack('H*')
        assert_equal(str1, str2)
    end



end
