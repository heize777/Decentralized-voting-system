module.exports = async ({ getNamedAccounts, deployments}) => {
  const { firstAccount } = await getNamedAccounts()
  const { deploy } = await deployments

  await deploy('Vote', {
    from: firstAccount,
    args: [["张三", "李四"]],
  })

  const voteContract = await deployments.get('Vote')

  console.log(voteContract)
}