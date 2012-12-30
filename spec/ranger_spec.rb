describe "Ranger!" do

  before { clear_project }

  it "should sync to default" do
    env "test" => "value"
    run_ranger
    assert_synced "test" => "value"
  end

  it "should sync to env" do
    default "test" => "value"
    run_ranger
    assert_synced "test" => "value"
  end
end
