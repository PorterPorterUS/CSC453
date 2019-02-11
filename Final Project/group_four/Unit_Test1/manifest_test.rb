require "test/unit"
load "./manifest.rb"

class ManifestTest < Test::Unit::TestCase

    def test_manifest()
        # test pack and unpack
        text = "de400bee8d5079600fe1fbb36b3f93673de82bb0 foo.txt\n"

        map = Hash.new()
        Mdiff.linesplit(text).each do |l|
            # #TODO: change unhexify
            map[l[41...-1]] = [l[0...40]].pack('H*')
        end

        gt_map = {"foo.txt" => ["de400bee8d5079600fe1fbb36b3f93673de82bb0"].pack("H*")}

        assert_equal(gt_map, map)
    end
end
