describe "Envs!" do

  before { clear_project }

  it "should sync to default" do
    env "test" => "value"
    run_envs
    assert_synced "test" => "value"
  end

  it "should sync to env" do
    default "test" => "value"
    run_envs
    assert_synced "test" => "value"
  end
end
